#!/usr/bin/env python3

# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

import os
import subprocess
import tempfile
import argparse
import urllib.request
from pathlib import Path

sub = "auto?trusted=1"

def run(cmd, check=True, **kwargs):
    print(f"+ {' '.join(cmd)}")
    subprocess.run(cmd, check=check, **kwargs)

def set_system_profile(mount_point: str, system_path: str, verbosity: list[str], extra_build_flags: list[str]):
    print("Setting system profile...")
    run([
        "nix-env", "--store", mount_point, *extra_build_flags,
        "--extra-substituters", sub,
        "-p", f"{mount_point}/nix/var/nix/profiles/system",
        "--set", system_path, *verbosity
    ])

def install_bootloader(mount_point: str):
    print("Installing bootloader...")
    os.environ["mountPoint"] = mount_point
    nixos_enter_cmd = [
        "nixos-enter", "--root", mount_point, "-c", '''
set -e
hash -r
mount --rbind --mkdir / "$mountPoint"
mount --make-rslave "$mountPoint"
/run/current-system/bin/switch-to-configuration boot
umount -R "$mountPoint" && (rmdir "$mountPoint" 2>/dev/null || true)
'''
    ]
    run(nixos_enter_cmd, shell=False)

def realize_target_system(toplevel_path: str, mount_point: str, verbosity: list[str], extra_build_flags: list[str]):
    # download the list of toplevel
    run(["nix-store",
         "--realize",
         "--store", mount_point,
         *extra_build_flags,
         "--extra-substituters", sub,
         *verbosity,
         toplevel_path
    ])

def fetch_available_toplevels(registry_uri: str) -> dict[str, str]:
    result: dict[str, str] = {}
    with urllib.request.urlopen(registry_uri) as response:
        for line in response:
            decoded = line.decode().strip()
            if not decoded or decoded.startswith('#'):
                continue
            parts = decoded.split(None, 1)
            if len(parts) == 2:
                key, value = parts
                result[key] = value
            else:
                print(f'Warning: the list of toplevels has unrecognised line such as "{decoded}"')
    return result

def touch_nixos_marker(mount_point):
    path = Path(mount_point) / "etc" / "NIXOS"
    path.parent.mkdir(parents=True, exist_ok=True)  # Ensure /etc exists
    path.touch(exist_ok=True)


def get_serial_number() -> str | None:
    path = "/sys/class/dmi/id/product_serial"
    try:
        with open(path) as f:
            return f.read().strip()
    except Exception:
        return None

def install_nixos(args):
    print("==> Starting NixOS installation...")
    with tempfile.TemporaryDirectory(dir=args.mountpoint, ignore_cleanup_errors=True) as tmpdir:
        os.environ["TMPDIR"] = os.environ.get("TMPDIR", tmpdir)

        system_path = None
        toplevels = {}
        if args.default_toplevel is not None:
            toplevels[args.default_toplevel] = args.default_toplevel

        if args.toplevel_registry_uri is not None:
            try:
                toplevels = fetch_available_toplevels(args.toplevel_registry_uri)
            except Exception:
                pass

        print(f'==> {len(toplevels)} systems available for installation.')

        if args.selected_toplevel is None:
            args.selected_toplevel = get_serial_number()
            print(f'==> Auto-selected system based on serial number "{args.selected_toplevel}"')
        else:
            toplevels[args.selected_toplevel] = args.selected_toplevel

        if args.selected_toplevel is not None and args.selected_toplevel not in toplevels:
            print('==> No specialized toplevel found')
            if args.default_toplevel is not None:
                print('==> Selecting the default system as one is specified')
                args.selected_toplevel = args.default_toplevel

        if args.selected_toplevel is not None and args.selected_toplevel in toplevels:
            toplevel = toplevels[args.selected_toplevel]
            print(f'==> Installing {toplevel}"')
            realize_target_system(toplevel, args.mountpoint, ['-v'] * args.verbosity, args.extra_build_flags)
            system_path = toplevel
        else:
            raise RuntimeError(f'No such toplevel among available ones: "{args.selected_toplevel}"')

        touch_nixos_marker(args.mountpoint)
        set_system_profile(args.mountpoint, system_path, ['-v'] * args.verbosity, args.extra_build_flags)
        install_bootloader(args.mountpoint)
        print("==> NixOS installation complete.")

def parse_args():
    parser = argparse.ArgumentParser(
        description="NixOS Installer Helper Script"
    )

    parser.add_argument(
        "--mountpoint",
        default="/mnt",
        type=str,
        help="Target mount point for NixOS installation (default: /mnt)"
    )

    parser.add_argument(
        "--toplevel-registry-uri",
        default=None,
        type=str,
        help="An URI to a list of available toplevels"
    )

    parser.add_argument(
        "--default-toplevel",
        default=None,
        type=str,
        help="What toplevel to install by default"
    )

    parser.add_argument(
        "--selected-toplevel",
        default=None,
        type=str,
        help="A specific toplevel in the list of toplevels (for auto-install)"
    )

    parser.add_argument(
        "-v", "--verbosity",
        action="count",
        default=0,
        help="Increase verbosity (-v, -vv for more)"
    )

    parser.add_argument(
        "--extra-build-flags",
        nargs="+",
        default=[],
        help="Extra build flags to pass to nix-env"
    )

    return parser.parse_args()

if __name__ == "__main__":
    try:
        args = parse_args()
        install_nixos(args)
    except Exception as e:
        print(f"ERROR: {e}")
        exit(1)

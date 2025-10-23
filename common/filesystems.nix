# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{ lib, ... }:
{
  securix.filesystems = {
    enable = true;

    # This creates a subvolume for /home and /var.
    # Instead of just /var.
    # This ensures also an encrypted swap.
    # It assumes that the LUKS device gets decrypted via FIDO2.
    layout = lib.mkDefault "office_v1";
  };

  boot.initrd.systemd.enable = true;

  # swapDevices = [
  #   {
  #     device = "/dev/disk/by-partlabel/swap";
  #     # TODO: this makes hibernation impossible, should we do it?
  #     randomEncryption = {
  #       cipher = "serpent-xts-plain64";
  #       enable = true;
  #       source = "/dev/random";
  #     };
  #   }
  # ];
}

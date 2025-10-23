<!--
SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>

SPDX-License-Identifier: MIT
-->

# Common modules for office work

Here, you will find common modules for the base of Bureautix, it will contain two types of modules:

- critical modules for filesystems, IT staff operations and so on
- modules to customize your browser, add new essential programs to your usecases, printing, power optimizations.

## How do I customize?

Start by:

- `./pam_u2f.nix`: choose an application ID and origin ID for all PAM U2F tokens
- `./admins.nix`: customize your IT staff accounts and their PAM U2F accounts
- `./superadmins.nix`: customize the people allowed to SSH to your office laptops if given the choice
- `./known-hosts.nix`: add your CAs and known hosts
- `./browser.nix`: add your bookmarks and a start page to help your users
- `./tools.nix`: add missing tools
- `./printing.nix`: add missing printer drivers

For the rest, you will have to explore it on your own!

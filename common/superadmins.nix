# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{
  securix.superadmins = {
    enable = true;
    keys = [ ];
  };

  # password is `nixos`
  users.users.root.hashedPassword = "$y$j9T$1aoCSeVE6c0STJ0MLSVjK/$jNxZFMVj..HMf5/l14b6I4VufioAr/cNp29ea1S4C4D";
}

# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{
  securix.pam.u2f = {
    enable = true;

    appId = "pam://bureautix-exemple";
    origin = "pam://bureautix-exemple";
  };
}

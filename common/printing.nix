# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{ pkgs, ... }:
{
  services.printing.enable = true;
  services.printing.drivers = [
    # Canon (InkJet) printer drivers
    pkgs.cnijfilter2
    # Add your organization printer drivers!
  ];
}

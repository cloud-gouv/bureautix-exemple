# SPDX-FileCopyrightText: 2025 Elias Coppens <elias.coppens@numerique.gouv.fr>
# SPDX-FileContributor: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{ lib, ... }:
{
  securix.firefox.bookmarks =
    let
      mkBookmarkWithIcon = icon: suffix: hostname: {
        name = "${hostname}";
        value = {
          inherit icon;
          href = "https://${hostname}.${suffix}";
        };
      };
    in
    {
    };
}

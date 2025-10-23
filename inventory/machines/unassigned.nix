# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{ config, ... }:
{
  warnings = [
    ''
      User «${config.securix.self.user.username or "unknown user"}» has no machine assigned.
      The final image might not work on the target system.

      Before building the system image for this user, consider creating a new machine in the inventory
      and assigning it to the user.
    ''
  ];
  securix.self.mainDisk = "/dev/nvme0n1";
  securix.self.machine = {
    hardwareSKU = "x280";
    serialNumber = "00000000";
  };
}

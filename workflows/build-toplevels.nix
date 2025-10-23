# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

_:

{
  name = "Build the toplevel registry";
  on = [
    "push"
    "pull_request"
  ];

  jobs.build-toplevel-registry = {
    runs-on = "ubuntu-latest";
    steps = [
      { uses = "actions/checkout@08eba0b27e820071cde6df949e0beb9ba4906955"; }
      {
        name = "Install Lix";
        uses = "samueldr/lix-gha-installer-action@8dc19fbd6451fa106a68ecb2dafeeeb90dff3a29";
      }
      {
        name = "Build";
        run = "nix-build -A toplevelRegistry";
      }
    ];
  };
}

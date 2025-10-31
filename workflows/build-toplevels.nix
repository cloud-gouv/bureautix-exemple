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
        uses = "samueldr/lix-gha-installer-action@8c7f8a4b0f594ab8a6dc3bf71c217587bbc756b5";
      }
      {
        name = "Build";
        run = "nix-build -A toplevelRegistry";
      }
    ];
  };
}

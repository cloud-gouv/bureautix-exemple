# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{ nix-actions, ... }:

{
  name = "Run pre-commit on all files";
  on = [
    "push"
    "pull_request"
  ];

  jobs.pre-commit = {
    runs-on = "ubuntu-latest";
    steps = [
      { uses = "actions/checkout@08eba0b27e820071cde6df949e0beb9ba4906955"; }
      {
        name = "Install Lix";
        uses = "samueldr/lix-gha-installer-action@8dc19fbd6451fa106a68ecb2dafeeeb90dff3a29";
      }
    ]
    # Inspired by DGNum's way of checking for pre-commit hooks.
    ++ (builtins.map
      (stage: {
        name = "Check stage ${stage}";
        run = nix-actions.lib.nix-shell {
          script = "pre-commit run --all-files --hook-stage ${stage} --show-diff-on-failure";
          shell = "pre-commit";
        };
      })
      [
        "pre-commit"
        "pre-push"
      ]
    );
  };
}

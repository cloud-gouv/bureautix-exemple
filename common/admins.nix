# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{
  # Configure multiple user-identified privilege separation users for the IT.
  # These accounts can be used to finish the user personalization.
  securix.admins = {
    enable = true;

    accounts = {
      rlahfa-adm = {
        # Generated with pamu2cfg --appid pam://bureautix-exemple --origin pam://bureautix-exemple --n
        u2f_keys = [
          "GwkjO84QPbW7WlJmFiizmZizbg8QZx2WRv3uZlW9zPHDFvCU9AgmDb+7wdOb1LCXjvsKl18HNkfl99v0fB3hRg==,vq7GaYWey9xNlokMpPmpVRIaOPL57L9tRBCOoifkeD5xBqvn12q5nPXr976gJZYtOnyRWjR/pazYKIXkwKFR6g==,es256,+presence"
        ];
      };

      heloise-adm = {
        u2f_keys = [ ];
      };

      abelard-adm = {
        u2f_keys = [ ];
      };
    };
  };
}

{ inputs, ... }:

{
  flake.modules.homeManager.options-development =
    { pkgs, ... }:
    {
      programs.git = {
        enable = true;

        settings = {
          user = {
            name = "subhajyotidev";
            email = "mrdeadlock8@gmail.com";
          };

          url = {
            "git@github.com:".insteadOf = "gh:";
            "git@gitlab.com:".insteadOf = "gl:";
            "git@codeberg.org:".insteadOf = "cb:";
            "git@git.sr.ht:".insteadOf = "sh:";
          };
        };
      };

      services.gpg-agent = {
        enable = true;
        enableFishIntegration = true;
        enableSshSupport = true;

        pinentry.package = inputs.pinentry-dms.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };
}

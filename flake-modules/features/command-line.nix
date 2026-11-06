{ lib, ... }:

{
  flake.modules.homeManager.options-command-line =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.commandLine.enable = lib.mkEnableOption "command-line utilities";

      config = lib.mkIf config.commandLine.enable {
        home.packages = with pkgs; [
          ripgrep
          ripgrep-all
          nix-search-tv
          nix-output-monitor
          linuxPackages.cpupower
          jujutsu
          koji
          fd
          wl-clipboard
          nix-prefetch-github
          jq
          eza
          bat
        ];
      };
    };
}

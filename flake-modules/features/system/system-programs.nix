{ ... }:

{
  flake.modules.nixos.system-programs = {
    programs.fish.enable = true;
    programs.kdeconnect.enable = true;
    programs.firefox.enable = true;
  };
}

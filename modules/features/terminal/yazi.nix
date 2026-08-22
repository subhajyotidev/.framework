{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "yy";

    # remaining friend's settings/plugins/keybindings
  };
}

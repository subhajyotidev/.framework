{ inputs, pkgs, ... }:

{
  flake.modules.homeManager.dux-files = {
    imports = [
      inputs.dfiles.homeModules.dux-files
    ];

    programs.dux-files = {
      enable = true;

      # Use a custom package (optional)
      package = inputs.dfiles.packages.${pkgs.stdenv.hostPlatform.system}.default;

      # The Quickshell package that runs the UI
      quickshell.package = pkgs.quickshell;

      # Keep a resident instance so windows open fast and the portal answers at once
      systemd = {
        enable = true;
        target = "graphical-session.target";
        restartIfChanged = true;
      };

      # Serve other apps' open and save dialogs
      portal = {
        enable = true; # register the dfiles backend with xdg-desktop-portal
        preferred = true; # prefer it for org.freedesktop.impl.portal.FileChooser
        desktop = "niri"; # which xdg.portal.config entry gets the preference, "common" by default
      };
    };
  };
}

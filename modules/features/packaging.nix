{ inputs, pkgs, ... }:

{
  services.flatpak.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;

    package = pkgs.appimage-run.override {
      extraPkgs = pkgs: [
        pkgs.libxcrypt
        pkgs.icu
      ];
    };
  };
}

{ ... }:

{
  flake.modules.nixos.system-services = { pkgs, ... }: {
    # System services
    services.fail2ban.enable = true;
    services.accounts-daemon.enable = true;
    services.colord.enable = true;
    services.fwupd.enable = true;
    services.power-profiles-daemon.enable = true;
    services.upower.enable = true;
    services.avahi.enable = true;
    services.printing.enable = true;

    # GVFS
    services.gvfs = {
      enable = true;
      package = pkgs.gnome.gvfs;
    };

    # Security services
    security.polkit.enable = true;
    security.rtkit.enable = true;
  };
}

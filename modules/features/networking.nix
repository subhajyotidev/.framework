{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos";

    firewall = {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];

      allowedUDPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
    };

    networkmanager.enable = true;
  };

  programs.nm-applet.enable = true;

  services.openssh = {
    enable = true;

    ports = [ 54321 ];

    openFirewall = true;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "delllaptop" ];
    };
  };

  services.endlessh = {
    enable = true;
    port = 22;
    openFirewall = true;
  };

  programs.openvpn3.enable = true;

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
  };
}

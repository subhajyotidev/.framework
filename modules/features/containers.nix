{ pkgs, ... }:

{
  virtualisation = {
    containers.enable = true;

    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;

      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };
  };

  environment.systemPackages = [
    pkgs.podman-compose
  ];
}

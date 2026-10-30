{ ... }:
{
  flake.modules.nixos.test = {
    networking.networkmanager.enable = true;
  };
}

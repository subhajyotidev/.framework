{ inputs, ... }:

{
  flake.modules.nixos.piri = {
    imports = [
      inputs.piri.nixosModules.piri
    ];

    services.piri.enable = true;
  };
}

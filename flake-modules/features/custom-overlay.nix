{ inputs, ... }:

{
  flake.modules.nixos.custom-overlay = {
    nixpkgs.overlays = [
      (import ../../overlays/custom.nix {
        inherit inputs;
      })
    ];
  };
}

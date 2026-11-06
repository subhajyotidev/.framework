{ self, ... }:

{
  flake.modules.nixos.custom-overlay = {
    nixpkgs.overlays = [
      self.overlays.custom
    ];
  };
}

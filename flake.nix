{
  description = "My NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-source = {
      url = "github:niri-wm/niri";
      flake = false;
    };

    niri = {
      url = "github:sodiboo/niri-flake/6bb99ff875919f03ea6054026619d999061e1170";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.niri-unstable.follows = "niri-source";
    };

    piri = {
      url = "github:Asthestarsfalll/piri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, ... }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [
          inputs.niri.overlays.niri
        ];
      };
    in
    {
      nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./configuration.nix

          inputs.niri.nixosModules.niri

          {
            programs.niri = {
              enable = true;
              package = pkgs.niri-unstable;
            };
          }
        ];
      };

      homeConfigurations.delllaptop =
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit system inputs;
          };

          modules = [
            inputs.niri.homeModules.niri
            ./subhajyoti.nix
          ];
        };
    };
}

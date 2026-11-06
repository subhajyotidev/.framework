{
  inputs,
  self,
  withSystem,
  ...
}:

{
  # Register the existing Home Manager configuration
  # as a reusable Home Manager module.
  flake.modules.homeManager."users-delllaptop" = ../../subhajyoti.nix;

  # Restore the standalone Home Manager configuration.
  flake.homeConfigurations.delllaptop = withSystem "x86_64-linux" (
    { system, ... }:

    let
      pkgs = import inputs.nixpkgs {
        inherit system;

        config.allowUnfree = true;

        overlays = [
          inputs.niri.overlays.niri
          inputs.helix.overlays.default
          inputs.nur.overlays.default
          (import ../../overlays/daw.nix)
          (import ../../overlays/custom.nix {
            inherit inputs;
          })
        ];
      };
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit inputs system;
      };

      modules = [
        self.modules.homeManager.options-desktop
        self.modules.homeManager.options-daw
        self.modules.homeManager.options-terminal
        self.modules.homeManager.options-development
        self.modules.homeManager.options-packaging
        self.modules.homeManager.options-media
        self.modules.homeManager.options-communication
        self.modules.homeManager.browsers
        self.modules.homeManager.editors
        self.modules.homeManager.options-applications
        self.modules.homeManager.options-command-line
        self.modules.homeManager."users-delllaptop"

        {
          desktop.niri.enable = true;
          desktop.niri.dms.enable = true;
          daw.enable = true;
          desktop.appearance.enable = true;
          homePackaging.flatpak.enable = true;
          media.obs.enable = true;
          communication.vesktop.enable = true;
          applications.enable = true;
          commandLine.enable = true;
        }
      ];
    }
  );
}

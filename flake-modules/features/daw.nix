{ lib, ... }:

{
  # Shared DAW package overlay for NixOS.
  flake.modules.nixos.daw-overlay = {
    nixpkgs.overlays = [
      (import ../../overlays/daw.nix)
    ];
  };

  # Home Manager DAW feature.
  flake.modules.homeManager.options-daw =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.daw.enable = lib.mkEnableOption "DAW tools and plugins";

      config = lib.mkIf config.daw.enable {
        home.packages = with pkgs; [
          reaper
          yabridge
          yabridgectl
        ];

        home.file = {
          ".clap/NeuralRack.clap".source = "${pkgs.neuralrack}/lib/clap/NeuralRack.clap";

          ".clap/Ratatouille.clap".source = "${pkgs.ratatouille}/lib/clap/Ratatouille.clap";

          ".clap/Plugdata.clap".source = "${pkgs.plugdata}/lib/clap/Plugdata.clap";

          ".clap/Cardinal.clap".source = "${pkgs.cardinal}/lib/clap/Cardinal.clap";

          ".clap/DragonflyReverb.clap".source = "${pkgs.dragonfly-reverb}/lib/clap";

          ".clap/LSPPlugins.clap".source = "${pkgs.lsp-plugins}/lib/clap";

          ".clap/SurgeXT.clap".source = "${pkgs.surge-xt}/lib/clap";

          ".lv2/x42Plugins.lv2".source = "${pkgs.x42-plugins}/lib/lv2";

          ".vst3/Stochas.vst3".source = "${pkgs.stochas}/lib/vst3/Stochas.vst3";
        };

        xdg.configFile = {
          "REAPER/UserPlugins/reaper_reapack-x86_64.so".source =
            "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";

          "REAPER/UserPlugins/reaper_sws-x86_64.so".source =
            "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";
        };
      };
    };
}

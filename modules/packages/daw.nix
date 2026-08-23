{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      reaper = prev.reaper.overrideAttrs (_: {
        version = "7.78";

        src = prev.fetchurl {
          url = "https://www.reaper.fm/files/7.x/reaper778_linux_x86_64.tar.xz";
          hash = "sha256-1mLrNdyrf9LOX6xqYJITYu8DPi0HXHTM75dPu9E6ZUI=";
        };
      });

      neuralrack = prev.stdenv.mkDerivation rec {
        pname = "neuralrack";
        version = "0.4.1";

        src = prev.fetchgit {
          url = "https://github.com/brummer10/NeuralRack.git";
          tag = "v${version}";
          hash = "sha256-60b18rAj4Za0H1lzPzvRYQdLFMYCBkKGMmSYJGBOaIQ=";
          fetchSubmodules = true;
        };

        nativeBuildInputs = [
          prev.pkg-config
          prev.gnumake
        ];

        buildInputs = [
          prev.libsndfile
          prev.cairo
          prev.libX11
        ];

        buildPhase = ''
          runHook preBuild
          make clap AR=gcc-ar RANLIB=gcc-ranlib
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          install -Dm755 \
            NeuralRack/NeuralRack.clap \
            "$out/lib/clap/NeuralRack.clap"
          runHook postInstall
        '';
      };

      ratatouille = prev.stdenv.mkDerivation rec {
        pname = "ratatouille";
        version = "0.9.11";

        src = prev.fetchFromGitHub {
          owner = "brummer10";
          repo = "Ratatouille.lv2";
          tag = "v${version}";
          hash = "sha256-mig3yUGSNz1xuyz6ljKqJUjNqmEcsbXSH1vTxTGdOFk=";
          fetchSubmodules = true;
        };

        nativeBuildInputs = [
          prev.pkg-config
          prev.gnumake
        ];

        buildInputs = [
          prev.libsndfile
          prev.cairo
          prev.libX11
        ];

        buildPhase = ''
          runHook preBuild
          make clap AR=gcc-ar RANLIB=gcc-ranlib
          runHook postBuild
        '';

        installPhase = ''
          runHook preInstall
          install -Dm755 \
            Ratatouille/Ratatouille.clap \
            "$out/lib/clap/Ratatouille.clap"
          runHook postInstall
        '';
      };
    })
  ];
}

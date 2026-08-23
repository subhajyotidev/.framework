{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {

      # Blender with CUDA support
      blender = prev.blender.override {
        cudaSupport = true;
      };

      # OBS Studio with CUDA support
      obs-studio = prev.obs-studio.override {
        cudaSupport = true;
      };

      # Papirus folders wrapper
      papirus-folders =
        prev.runCommand "papirus-folders"
          {
            nativeBuildInputs = [ prev.makeWrapper ];
          }
          ''
            ${prev.lib.getExe' prev.coreutils "mkdir"} -p $out/bin

            makeWrapper ${prev.lib.getExe prev.papirus-folders} \
              $out/bin/papirus-folders \
              --prefix PATH : ${prev.lib.makeBinPath [ prev.gtk3 ]}
          '';

      # Sioyek — force X11 backend
      sioyek = prev.sioyek.overrideAttrs (old: {
        nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ prev.makeWrapper ];

        postInstall = (old.postInstall or "") + ''
          wrapProgram $out/bin/sioyek \
            --set QT_QPA_PLATFORM xcb
        '';
      });

      # NeuralRack CLAP plugin
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

      # Ratatouille CLAP plugin
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

      # WiiUDownloader AppImage
      wiiudownloader =
        let
          version = "2.100";

          src = prev.fetchurl {
            url = "https://github.com/Xpl0itU/WiiUDownloader/releases/download/v${version}/WiiUDownloader-Linux-x86_64.AppImage";
            hash = "sha256-Tz5c9VvWtDqs5tog1cDYX8pKYqecu29ed93ZUi9TSK4=";
          };

          appimageContents = prev.appimageTools.extractType2 {
            pname = "WiiUDownloader";
            inherit version src;
          };
        in
        prev.appimageTools.wrapType2 {
          pname = "WiiUDownloader";
          inherit version src;

          extraInstallCommands = ''
            export INSTALL='${prev.lib.getExe' prev.coreutils "install"}'

            "$INSTALL" -m 444 -D \
              ${appimageContents}/WiiUDownloader.desktop \
              $out/share/applications/WiiUDownloader.desktop

            "$INSTALL" -m 444 -D \
              ${appimageContents}/WiiUDownloader.png \
              $out/share/icons/hicolor/512x512/apps/WiiUDownloader.png

            substituteInPlace \
              $out/share/applications/WiiUDownloader.desktop \
              --replace 'Exec=AppRun' 'Exec=WiiUDownloader'
          '';
        };

      # Waydroid GPU selector
      waydroid-choose-gpu = prev.writers.writeFishBin "waydroid-choose-gpu" { } ''
        set CP        ${prev.lib.getExe' prev.coreutils "cp"}
        set DATE      ${prev.lib.getExe' prev.coreutils "date"}
        set RG        ${prev.lib.getExe prev.ripgrep}
        set LSPCI     ${prev.lib.getExe prev.pciutils}
        set SD        ${prev.lib.getExe prev.sd}
        set WAYDROID  ${prev.lib.getExe prev.waydroid-nftables}

        set lspci_out ("$LSPCI" -nn | "$RG" '\[03')

        if test -z "$lspci_out"
          echo "No GPUs found."
          exit 1
        end

        echo -e "Please enter the GPU number you want to pass to WayDroid:\n"

        set -l i 0

        for line in $lspci_out
          set i (math $i + 1)
          echo "  $i. $line"
        end

        set -l gpuchoice ""

        while test -z "$gpuchoice"
          read -l -P ">> Number of GPU to pass to WayDroid (1-$i): " ans

          if string match -qr '^[0-9]+$' "$ans"
            and test "$ans" -ge 1
            and test "$ans" -le "$i"

            set -l selected_line $lspci_out[$ans]
            set gpuchoice (string split " " $selected_line)[1]
          end
        end

        echo -e "\nConfirming DRI nodes for GPU: $gpuchoice\n"

        set -l dri_paths \
          (ls -l /dev/dri/by-path/ | "$RG" -i "$gpuchoice")

        echo "$dri_paths"

        set -l card \
          (echo "$dri_paths" | "$RG" -o "card[0-9]" | head -n1)

        set -l rendernode \
          (echo "$dri_paths" | "$RG" -o "renderD[0-9]{3}" | head -n1)

        if test -z "$card"; or test -z "$rendernode"
          echo "Could not find DRI nodes for $gpuchoice"
          exit 1
        end

        echo "Selected: /dev/dri/$card & /dev/dri/$rendernode"

        set -l timestamp ("$DATE" +%Y-%m-%d-%H:%M)

        set -l config_nodes \
          "/var/lib/waydroid/lxc/waydroid/config_nodes"

        set -l waydroid_cfg \
          "/var/lib/waydroid/waydroid.cfg"

        if test -f "$config_nodes"
          run0 "$CP" \
            "$config_nodes" \
            "$config_nodes"_"$timestamp".bak
        end

        if test -f "$waydroid_cfg"
          run0 "$CP" \
            "$waydroid_cfg" \
            "$waydroid_cfg"_"$timestamp".bak

          run0 "$SD" \
            '(?m)^drm_device\s*=.*$\n?' \
            "" \
            "$waydroid_cfg"

          run0 "$SD" \
            '(\[waydroid\])' \
            '$1\ndrm_device = /dev/dri/'"$rendernode" \
            "$waydroid_cfg"
        end

        run0 "$WAYDROID" upgrade --offline
      '';

      # Waydroid script wrapper
      waydroid-script = prev.writeShellScriptBin "waydroid-script" ''
        exec ${
          prev.lib.getExe' inputs.waydroid-script.packages.${prev.system}.default "waydroid_script"
        } "$@"
      '';
    })
  ];
}

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
    inputs.nix-flatpak.homeManagerModules.nix-flatpak

    ./modules/features/terminal/helix.nix
    ./modules/features/terminal/fish.nix
    ./modules/features/browsers.nix
    ./modules/features/browsers/librewolf.nix
    ./modules/features/browsers/helium.nix
    ./modules/features/terminal/starship.nix
    ./modules/features/terminal/yazi.nix
    ./modules/features/terminal/zellij.nix
    ./modules/features/editors/emacs.nix
    ./modules/features/editors/zed-editor.nix
    ./modules/packages/daw.nix
  ];

  home.username = "delllaptop";
  home.homeDirectory = "/home/delllaptop";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    packages = [
      "com.github.tchx84.Flatseal"
      "io.github.flattool.Warehouse"
      "com.usebottles.bottles"
    ];

    update.auto.enable = true;
    update.auto.onCalendar = "daily";
  };

  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;

    dgop.package = inputs.dgop.packages.${pkgs.system}.default;

    niri = {
      enableKeybinds = false;
      enableSpawn = true;
    };

    plugins = {
      batteryPlus = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "batteryPlus";
          rev = "4e653d09174e1edc260f279c42ec2477b6fb2e24";
          hash = "sha256-XEAvnTisFTPs55+uVCDeHXSJthtkE0CU6No29TDyAYY=";
        };
      };

      calculator = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "calculator";
          rev = "1db5865419a40a33171a475855a59e0b8bf7187f";
          hash = "sha256-j8C62+sevr6b+akzVSAqUVysIhb6Vbr8jnWcTXeOtE8=";
        };
      };

      clipboardPlus = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "clipboardPlus";
          rev = "46405816d7e69af59026d10447c93262c645296c";
          hash = "sha256-7B7zyzOQ4vjWjyZv8dAHy+ViT3SjsbcLMO1Y9NFvHxs=";
        };
      };

      commandRunner = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "commandRunner";
          rev = "35277695de06beadaba701cb94cc8b096b233319";
          hash = "sha256-o43IyVT901ZzZGDvZKWhlrgMba57thAoqL3+BFaFV74=";
        };
      };

      dockerManager = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "dockerManager";
          rev = "255f46794b6e3a5f5e842fe1330db3869deddc09";
          hash = "sha256-YDCwXF0dyuNy07voKvkLlKfHFfPkhSS4oGopn+EnM+0=";
        };
      };

      emojiLauncher = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "emojiLauncher";
          rev = "1c0a7d337a52b48f9499060076703a35e8dd4f4f";
          hash = "sha256-NQ14YenDiNK2VqXQ3z7jAkatbSRtYJHhOhvv7AJlUD8=";
        };
      };

      niriWindows = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "niriWindows";
          rev = "f2c0b0fc0325e3299257cc5d1895069a3d49247f";
          hash = "sha256-uKNiqr/DiX28dePBqsEfBPaCB/kmVDzjayXHdIwGkZQ=";
        };
      };

      wallpaperCarousel = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "wallpaperCarousel";
          rev = "c08fbb92c39d4d778bb08e520cfd96e395594440";
          hash = "sha256-t70CBhiEBYHa9HvPpCZnfA8eCOWhUlXc6SUa9VprFNE=";
        };
      };

      webSearch = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "webSearch";
          rev = "8ec42a2dff96b94cdd0d40b57c1acd815c15079a";
          hash = "sha256-S1A50s7cKE0NuidC+x589wIxqGA6JW8GrCVEkCddMQs=";
        };
      };

      DankHooks = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "dms-plugins";
          rev = "3ad0e7845b62a9aca56f7959dd086b2a85655079";
          hash = "sha256-gb+k5dsbPjV8KFFFC7Pvpm2AnMnPl+t27Okl5WoVXd8=";
          sparseCheckout = [ "DankHooks" ];
        };
      };

      DankKDEConnect = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "dms-plugins";
          rev = "3ad0e7845b62a9aca56f7959dd086b2a85655079";
          hash = "sha256-gb+k5dsbPjV8KFFFC7Pvpm2AnMnPl+t27Okl5WoVXd8=";
          sparseCheckout = [ "DankKDEConnect" ];
        };
      };

      DankNotepadModule = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "dms-plugins";
          rev = "3ad0e7845b62a9aca56f7959dd086b2a85655079";
          hash = "sha256-gb+k5dsbPjV8KFFFC7Pvpm2AnMnPl+t27Okl5WoVXd8=";
          sparseCheckout = [ "DankNotepadModule" ];
        };
      };

      dankPinentry = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "dankPinentry";
          rev = "02df8bceb651bdbc5fdc7a07b5f6f19e60c3906a";
          hash = "sha256-vyDIpTClqE1UheULRdVzg2XOr1BEhN+mWJPkMbn3V2g=";
          sparseCheckout = [ "plugin" ];
        };
      };

      ClipboardPlus = {
        src = pkgs.fetchFromGitHub {
          owner = "debarchito";
          repo = "dadan-dms-plugins";
          rev = "63fe6b87c497f1f7c2ea61432716817db1c5c3a4";
          hash = "sha256-m4XMKkBK8cxl3nj5J/2tbwU9hbO/Qu6Xo6SEcprFG1Q=";
          sparseCheckout = [ "ClipboardPlus" ];
        };
      };
    };
  };

  programs.obs-studio = {
    enable = true;

    plugins = [
      pkgs.obs-studio-plugins.obs-pipewire-audio-capture
      pkgs.obs-studio-plugins.obs-vkcapture
    ];
  };

  programs.niri = {
    package = pkgs.niri-unstable;
    config = builtins.readFile ./config/niri/config.kdl;
  };

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "subhajyotidev";
        email = "mrdeadlock8@gmail.com";
      };

      url = {
        "git@github.com:".insteadOf = "gh:";
        "git@gitlab.com:".insteadOf = "gl:";
        "git@codeberg.org:".insteadOf = "cb:";
        "git@git.sr.ht:".insteadOf = "sh:";
      };
    };
  };

  services.gpg-agent = {
    enable = true;
    enableFishIntegration = true;
    enableSshSupport = true;

    pinentry.package = inputs.pinentry-dms.packages.${pkgs.system}.default;
  };

  programs.vesktop.enable = true;

  programs.kitty = {
    enable = true;

    settings = {
      shell_integration = "enabled";

      hide_window_decorations = "yes";
      window_padding_width = 10;

      placement_strategy = "center";
      resize_in_steps = "yes";

      font_family = "Maple Mono NF";
      font_size = 14;

      font_features = "MapleMonoNF-Regular -calt -zero -cv02 +cv01 +cv61";

      text_composition_strategy = "legacy";
      notify_on_select = "no";
    };

    extraConfig = ''
      include themes/dankcolors.conf
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fzf = {
    enable = true;

    defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git";

    changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";

    changeDirWidgetOptions = [
      "--preview 'eza --tree --color=always {} | head -200'"
    ];

    fileWidgetCommand = "fd --hidden --strip-cwd-prefix --exclude .git";

    fileWidgetOptions = [
      "--preview 'bat --color=always -n --line-range :500 {}'"
    ];

    historyWidgetOptions = [ ];
  };

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
    "DankMaterialShell/settings.json".source = ./config/dms/settings.json;

    "DankMaterialShell/plugin_settings.json".source = ./config/dms/plugin_settings.json;

    "matugen".source = ./config/matugen;

    "qt5ct/qt5ct.conf".source = ./config/qt5ct/qt5ct.conf;

    "qt6ct/qt6ct.conf".source = ./config/qt6ct/qt6ct.conf;

    "niri/piri.toml".source = ./config/piri/piri.toml;

    "matugen/templates/kitty/dankcolors.conf".source = ./config/matugen/templates/kitty/dankcolors.conf;

    "matugen/templates/fish/dankcolors.fish".source = ./config/matugen/templates/fish/dankcolors.fish;

    "REAPER/UserPlugins/reaper_reapack-x86_64.so".source =
      "${pkgs.reaper-reapack-extension}/UserPlugins/reaper_reapack-x86_64.so";

    "REAPER/UserPlugins/reaper_sws-x86_64.so".source =
      "${pkgs.reaper-sws-extension}/UserPlugins/reaper_sws-x86_64.so";
  };

  qt = {
    enable = true;

    platformTheme = {
      name = "qtct";
    };
  };

  fonts.fontconfig = {
    enable = true;

    defaultFonts = {
      serif = [ "Lora" ];
      sansSerif = [ "Poppins" ];
      monospace = [ "Maple Mono NF" ];
    };
  };

  gtk = {
    enable = true;

    font = {
      name = "Poppins";
      size = 10;
    };

    gtk3.theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };

    gtk4.theme = config.gtk.theme;
  };

  home.packages = with pkgs; [
    qt6Packages.qt6ct
    libsForQt5.qt5ct

    lora
    poppins
    maple-mono.NF
    adw-gtk3
    papirus-icon-theme
    papirus-folders
    pear-desktop
    bitwarden-desktop
    blender
    sioyek
    wlr-which-key
    libreoffice
    davinci-resolve
    kdePackages.dolphin

    # Fish Stuff
    fish
    fzf
    ripgrep
    ripgrep-all
    nix-search-tv
    nix-output-monitor
    zoxide
    scrcpy
    linuxPackages.cpupower
    jujutsu
    koji
    fd
    wl-clipboard
    nix-prefetch-github
    jq
    eza
    bat

    # DAW
    reaper
    yabridge
    yabridgectl
  ];
}

{
  config,
  pkgs,
  inputs,
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
    blender
    sioyek

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

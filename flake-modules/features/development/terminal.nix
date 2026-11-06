{
  self,
  ...
}:

{
  flake.modules.homeManager.options-terminal = {
    imports = [
      self.modules.homeManager.fish
      self.modules.homeManager.helix
      self.modules.homeManager.starship
      self.modules.homeManager.yazi
      self.modules.homeManager.zellij
    ];

    # Kitty
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

    # Zoxide
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    # FZF
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
  };
}

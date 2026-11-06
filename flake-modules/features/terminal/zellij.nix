{
  flake.modules.homeManager.zellij = { ... }: {
    programs.zellij = {
      enable = true;
    };

    xdg.configFile."zellij/config.kdl".source = ../../../modules/features/terminal/zellij/config.kdl;
  };
}

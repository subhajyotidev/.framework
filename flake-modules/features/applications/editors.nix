{
  self,
  ...
}:
{
  flake.modules.homeManager.editors = {
    imports = [
      self.modules.homeManager.emacs
      self.modules.homeManager.zed-editor
    ];
  };
}

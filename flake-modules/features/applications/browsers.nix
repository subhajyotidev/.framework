{
  self,
  ...
}:
{
  flake.modules.homeManager.browsers.imports = [
    self.modules.homeManager.librewolf
    self.modules.homeManager.helium
  ];
}

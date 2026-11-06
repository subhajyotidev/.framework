{
  flake.modules.homeManager.librewolf =
    { lib, pkgs, ... }:
    import ../../../modules/features/browsers/librewolf.nix {
      inherit lib pkgs;
    };
}

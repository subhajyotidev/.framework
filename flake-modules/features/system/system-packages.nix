{ ... }:

{
  flake.modules.nixos.system-packages = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      cups-pk-helper
      normcap
    ];
  };
}

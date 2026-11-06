{ ... }:

{
  flake.modules.nixos.nix-tools = {
    # Nix daemon settings
    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];

      auto-optimise-store = true;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # Nix-related programs
    programs.nix-ld.enable = true;

    programs.nh = {
      enable = true;
      flake = "/home/delllaptop/.framework";

      clean = {
        enable = true;
        extraArgs = "--delete-older-than 7d --keep 2";
      };
    };
  };
}

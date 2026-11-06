{ ... }:

{
  flake.modules.nixos.user-account = { pkgs, ... }: {
    users.users.delllaptop = {
      isNormalUser = true;
      description = "dell-laptop";

      extraGroups = [
        "networkmanager"
        "wheel"
        "wheel"
        "kvm"
      ];

      packages = with pkgs; [
        kitty
        git
        alacritty
        fuzzel
        swaybg
        nerd-fonts.jetbrains-mono
        xwayland-satellite
        nautilus
      ];
    };
  };
}

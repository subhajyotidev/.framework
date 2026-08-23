{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      runAsRoot = true;
      swtpm.enable = true;

      vhostUserPackages = [
        pkgs.virtiofsd
      ];
    };
  };

  programs.virt-manager.enable = true;

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

  networking.firewall.trustedInterfaces = [
    "waydroid0"
  ];

  environment.systemPackages = [
    pkgs.waydroid-script
    pkgs.waydroid-choose-gpu
  ];
}

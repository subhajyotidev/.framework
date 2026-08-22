{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;

    qemu = {
      swtpm.enable = true;
      vhostUserPackages = [
        pkgs.virtiofsd
      ];
    };
  };

  programs.virt-manager.enable = true;
}

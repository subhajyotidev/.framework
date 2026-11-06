{ inputs, ... }:

{
  flake.modules.nixos.boot =
    { pkgs, ... }:
    {
      # CachyOS kernel overlay
      nixpkgs.overlays = [
        inputs.nix-cachyos-kernel.overlays.pinned
      ];

      # Swap configuration
      boot.initrd.luks.devices."cryptswap".device =
        "/dev/disk/by-uuid/cc567761-515d-41e9-8878-e97f46aedd5f";

      swapDevices = [
        {
          device = "/dev/mapper/cryptswap";
        }
      ];

      # ZRAM
      zramSwap = {
        enable = true;
        memoryPercent = 50;
      };

      # Zswap
      boot.kernelParams = [
        "zswap.enabled=1"
      ];

      # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.loader.systemd-boot.graceful = true;

      # CachyOS kernel
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;

      boot.kernelModules = [
        "ntsync"
      ];

      boot.tmp.cleanOnBoot = true;
    };
}

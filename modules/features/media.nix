{ inputs, pkgs, ... }:

{
  imports = [
    inputs.musnix.nixosModules.musnix
    inputs.mfctl.nixosModules.default
  ];

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;
  };

  programs.mfctl.enable = true;

  hardware.bluetooth.enable = true;

  environment.systemPackages = [
    pkgs.qpwgraph
  ];

  musnix = {
    enable = true;
    rtcqs.enable = true;

    kernel.packages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
  };

  services.pipewire.extraConfig.jack = {
    "10-clock-rate" = {
      "jack.properties" = {
        "node.latency" = "128/48000";
        "node.rate" = "1/48000";
        "node.lock-quantum" = true;
      };
    };
  };
}

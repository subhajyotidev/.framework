{ pkgs, ... }:

{
  # Bluetooth
  hardware.bluetooth.enable = true;

  # PipeWire
  services.pulseaudio.enable = false;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
    jack.enable = true;

    wireplumber.enable = true;
  };

  # Audio routing tool
  environment.systemPackages = [
    pkgs.qpwgraph
  ];
}

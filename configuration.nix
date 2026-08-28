# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/features/containers.nix
    ./modules/features/graphics.nix
    ./modules/features/gaming.nix
    ./modules/features/trusted-substituters.nix
    ./modules/features/virtualisation.nix
    ./modules/features/media.nix
    ./modules/features/networking.nix
    ./modules/features/packaging.nix
    ./modules/packages.nix
    ./modules/packages/daw.nix
    inputs.piri.nixosModules.piri
  ];

  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  # Zswap & Zram
  boot.initrd.luks.devices."cryptswap".device =
    "/dev/disk/by-uuid/cc567761-515d-41e9-8878-e97f46aedd5f";

  swapDevices = [
    {
      device = "/dev/mapper/cryptswap";
    }
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  boot.kernelParams = [
    "zswap.enabled=1"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
  boot.kernelModules = [ "ntsync" ];
  boot.tmp.cleanOnBoot = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Piri
  services.piri.enable = true;

  # Fish
  programs.fish.enable = true;

  # KDE Connect
  programs.kdeconnect.enable = true;

  # Fail2ban, nh..
  services.fail2ban.enable = true;

  # some needed services
  services.accounts-daemon.enable = true;
  services.colord.enable = true;
  services.fwupd.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
  services.avahi.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];
    auto-optimise-store = true;
  };

  programs.nix-ld.enable = true;

  programs.nh = {
    enable = true;
    flake = "/home/delllaptop/.framework";
    clean = {
      enable = true;
      extraArgs = "--delete-older-than 7d --keep 2";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."delllaptop" = {
    isNormalUser = true;
    description = "dell-laptop";
    extraGroups = [
      "networkmanager"
      "wheel"
      "kvm"
    ];
    packages = with pkgs; [
      #  thunderbird
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Allow unfree-pkgs for steamixpkgs.config.allowUnfree = true;

  services.gvfs = {
    enable = true;
    package = pkgs.gnome.gvfs;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    cups-pk-helper
    normcap
    #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}

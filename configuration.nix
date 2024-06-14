# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Johannesburg";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_ZA.UTF-8";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
    desktopManager.xterm.enable = false;
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Automatically Mount USBs
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mmibbetson = {
    isNormalUser = true;
    description = "Matthew Ibbetson";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [];
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  # NVidia
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Gaming
  programs.steam.enable = true;

  # Window Manager
  services.xserver = {
    enable = true;
    autorun = true;
    windowManager.bspwm.enable = true;
  };

  programs.nm-applet.enable = true;

  # Music Player Daemon
  services.mpd = {
    enable = true;
    musicDirectory = "/path/to/music";
    extraConfig = ''
      audio_output {
        type "pulse"
        name "Pulseaudio"
        server "127.0.0.1"
      }
    '';

    # Optional:
    # network.listenAddress = "any"; # if you want to allow non-localhost connections
    startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
  };

  # Enable docker
  virtualisation.docker.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    iosevka
    (nerdfonts.override { fonts = [ "Iosevka" "IosevkaTerm" ]; })
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [

    # CLI Programs
    alacritty
    fish
    fastfetch
    fzf
    git
    stow
    wget
    curl
    unzip
    ripgrep
    fd
    bat
    eza
    zoxide
    lazygit
    zathura
    yazi
    lazydocker
    bottom
    ncmpcpp

    # Window Manager Utilities
    pavucontrol
    gruvbox-gtk-theme
    papirus-icon-theme
    lxappearance
    redshift
    picom
    polybar
    dunst
    rofi
    feh
    xfce.thunar

    # Text Editors
    neovim
    jetbrains.rider
    vscode

    # Graphical Programs
    gimp
    mpv
    discord
    brave
    retroarch
    obsidian
    gparted

    # Programming Languages
    rustup
    # zig
    # gleam
    gcc
    luajit
    lua54Packages.lua
    lua54Packages.luarocks
    nodePackages_latest.pnpm
    bun
    deno
    dotnetCorePackages.dotnet_8.sdk
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
  system.stateVersion = "24.05"; # Did you read the comment?

}

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

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Automatically Mount USBs
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;

  # Interactive Shell
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mmibbetson = {
    isNormalUser = true;
    description = "Matthew Ibbetson";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh
    packages = with pkgs; [
      
      # CLI Programs
      alacritty
      powershell
      fastfetch
      fzf
      git
      stow
      wget
      zip
      curl
      unzip
      ripgrep
      fd
      bat
      eza
      zoxide
      jq
      yq
      lazygit
      yazi
      bottom
      ncmpcpp

      # Window Manager Utilities
      pavucontrol
      arc-theme
      papirus-icon-theme
      redshift
      picom
      polybar
      dunst
      rofi
      feh
      xclip
      flameshot

      # Virtualisation
      qemu
      quickemu
      quickgui
      podman
      podman-compose
      podman-desktop
      kubernetes

      # Text Editors
      helix
      jetbrains.rider
      vscodium

      # Graphical Programs
      gimp
      mpv
      discord
      brave
      firefox
      retroarch
      gparted
      postman
      protonup-qt
      xivlauncher

      # Programming Languages
      rustup
      zig
      clang
      gcc
      gdb
      valgrind
      nodePackages_latest.pnpm
      bun
      deno
      dotnetCorePackages.dotnet_8.sdk    
    ];
  };

  # Su stuff
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

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
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    windowManager.bspwm.enable = true;
  };

  programs.nm-applet.enable = true;

  # Music Player Daemon
  services.mpd = {
    enable = true;
    musicDirectory = "~/Music";
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

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    commit-mono
    (nerdfonts.override { fonts = [ "CommitMono" ]; })
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [];

  # Default Applications
  xdg.mime.defaultApplications = {
    "application/pdf" = "evince.desktop";       # Open PDF files in Evince
    "application/epub" = "evince.desktop";       # Open epub files in Evince
    "audio/*" = "mpv.desktop";                  # Open audio files in MPV
    "video/*" = "mpv.desktop";                  # Open video files in MPV
    "text/html" = "brave.desktop";              # Open HTML files in Brave browser
    "application/xhtml+xml" = "brave.desktop";  # Open XHTML files in Brave browser
    "image/*" = "feh.desktop";                  # Open any other image types in Feh
    "application/*" = "helix.desktop";          # Open any other application types in Emacs
    "text/*" = "helix.desktop";                 # Open any other text files in Emacs
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon
  services.openssh.enable = true;

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

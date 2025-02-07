# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  # Opt-in unstable packages.
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
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
  users.defaultUserShell = pkgs.zsh;

  # Deduplicate nix store on a timer
  nix.optimise.automatic = true;

  # Delete old generations
  nix.gc.automatic = true;
  nix.gc.dates = "weekly";
  nix.gc.options = "--delete-older-than 30d";

  # Version Control
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # Virtualisation (Docker)
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mmibbetson = {
    isNormalUser = true;
    description = "Matthew Ibbetson";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "docker" ];
    shell = pkgs.zsh;
    packages = with pkgs; [

      # CLI Programs
      alacritty
      starship
      nushell
      fastfetch
      fzf
      git
      lazygit
      stow
      curl
      wget
      zip
      unzip
      ripgrep
      fd
      sd
      bat
      eza
      zoxide
      jq
      bottom
      navi
      hyperfine
      tokei
      xclip
      openssl
      zola
      pandoc
      aider-chat

      # Virtualisation
      qemu
      quickemu
      distrobox

      # Text Editors
      unstable.helix
      jetbrains.rider
      vscode

      # Graphical Programs
      papirus-icon-theme
      gimp
      mpv
      discord
      brave
      firefox
      gparted
      postman
      gnome-tweaks
      protonup-qt
      retroarchFull
      heroic
      bookworm
      meld

      # Programming Languages
      tree-sitter
      luajit
      luajitPackages.luarocks
      luajitPackages.fennel
      go
      rustup
      typst
      racket
      guile
      clang
      janet
      jpm
      lldb
      gcc
      gdb
      valgrind
      nodejs_22
      pnpm
      dotnetCorePackages.dotnet_8.sdk

      # Language Servers & Formatters
      nodePackages.prettier
      yaml-language-server
      typescript-language-server
      vscode-langservers-extracted
    ];
  };

  # Su stuff
  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  # Enable OpenGL (now graphics?)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # NVidia
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Window Manager
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Fonts
  fonts.packages = with pkgs; [
    font-awesome
    commit-mono
    jetbrains-mono
    iosevka
    (nerdfonts.override { fonts = [ "IosevkaTerm" "CommitMono" "JetBrainsMono" ]; })
  ];

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [];

  # Default Applications
  xdg.mime.defaultApplications = {
    "application/pdf" = "evince.desktop";       # Open PDF files in Evince
    "application/epub" = "bookworm.desktop";      # Open epub files in Evince
    "audio/*" = "mpv.desktop";                  # Open audio files in MPV
    "video/*" = "mpv.desktop";                  # Open video files in MPV
    "text/html" = "brave.desktop";              # Open HTML files in Brave browser
    "application/xhtml+xml" = "brave.desktop";  # Open XHTML files in Brave browser
    "image/*" = "eog.desktop";                  # Open any other image types in Feh
    "application/*" = "nvim.desktop";           # Open any other application types in Neovim
    "text/*" = "nvim.desktop";                  # Open any other text files in Neovim
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

  # GPG
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryPackage = pkgs.pinentry-tty;

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
  system.autoUpgrade = {
    enable = true;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "02:00";
    randomizedDelaySec = "45min";
  };
}

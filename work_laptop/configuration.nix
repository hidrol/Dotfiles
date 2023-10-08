# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
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
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  #
  # # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  #
  # # Configure keymap in X11
  # services.xserver = {
  #   layout = "us";
  #   xkbVariant = "";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  # Enable sound with pipewire.
  # sound.enable = true;
  # hardware.pulseaudio.enable = false;
  # security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hidrol = {
    isNormalUser = true;
    description = "hidrol";
    #extraGroups = [ "networkmanager" "wheel" ];
    extraGroups = [ "wheel" "networkmanager" "lxd" "docker" "video" ];
    shell = pkgs.zsh;
    #packages = with pkgs; [
    #  firefox
    #  thunderbird
    #];
  };

  #hardware.pulseaudio.enable = true;
  sound.mediaKeys = {
    enable = true;
    volumeStep = "5%";
  };
  
  virtualisation.lxd.enable = true;
  virtualisation.docker.enable = true;

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "hidrol";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault false;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  # networking.interfaces.wwan0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp0s31f6.ipv4.addresses = [ {
    address = "192.168.10.95";
    prefixLength = 24;
  } ];

  networking.nameservers = [ "1.1.1.1" "9.9.9.9" "8.8.8.8" ];

  # networking = {
  #   defaultGateway = {
  #     address = "192.168.10.1";
  #     interface = "enp0s31f6";
  #   };
  # };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    #feh
#  compton
    #jstest-gtk
    unzip
    zip
    epdfview
    kitty
    kitty-themes
    neofetch
    zsh
    git
    wget 
    #tmux 
    joplin-desktop
    nextcloud-client
    ccls #c language server
    ctags #for neovim
    htop
    usbutils
    firefox
    xclip
    gcc
    libusb
    picom
    gparted
    lxc
    #xorg.xbacklight
    brightnessctl
    acpilight
    #vifm
    #gdb
    python3
    #lldb
    #gcc
    #alsa-lib
    #mesa
    #xorg.libX11
    #xorg.libXrandr
    #xorg.libXi
    #xorg.libXcursor
    #xorg.libXinerama
    #xorg.libXext
    #libatomic_ops
    #gnumake
    #cmake
    #glfw2
     #raylib
    auto-cpufreq
    ntfs3g
    pciutils
  ];

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;

  services.auto-cpufreq.enable = true;

  # programs.light.enable = true;
  # xev keycode have to be substracted with 8
  services.actkbd = {
    enable = true;
    bindings = [
      # brightness
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/xbacklight -dec 5"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/xbacklight -inc 5"; }

      #{ keys = [ 121 ]; events = [ "key" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master toggle"; }

      # "Lower Volume" media key
      # { keys = [ 60 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}- unmute"; }

      # "Raise Volume" media key
      # { keys = [ 61 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}+ unmute"; }
      #{ keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/amixer Master 8%-"; }
      #{ keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/amixer Master 8%+"; }
      # { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l hidrol -c 'amixer -q set Master 5%- unmute'"; }
      # { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l hidrol -c 'amixer -q set Master 5%+ unmute'"; }

    ];
  };

  #  services.udev.extraRules = ''
  #   ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/intel_backlight/brightness"
  # '';



  programs.zsh = {
    enable = true;
    #enableAutosuggestions = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    #	ohMyZsh = {
    #	    enable = true;
    #};
  };


  users.defaultUserShell = pkgs.zsh;

  environment.shells = with pkgs; [ zsh ];

  console = {
    font = "Lat2-Terminus16";
    #font = "FiraCode";
    #keyMap = "us";
	  useXkbConfig = true;
  };


  fonts.fonts = with pkgs; [
    fira-code
    fira-code-symbols
    (nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];

  services.openssh.enable = true;

  services.xserver.enable  = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.defaultSession  = "none+i3";
  services.xserver.layout  = "us";
  services.xserver.displayManager.lightdm.enable  = true;
  #services.xserver.displayManager.autoLogin.enable  = true;
  #services.xserver.displayManager.autoLogin.user  = "hidrol";
  services.xserver.xkbOptions = "ctrl:swapcaps";
  services.xserver.libinput.touchpad.naturalScrolling = true;
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
  system.stateVersion = "22.11"; # Did you read the comment?

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";
	};

  #myString = "${pkgs.tmuxPlugins.re
  environment.etc."testtest".source = "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/restore.sh";





}

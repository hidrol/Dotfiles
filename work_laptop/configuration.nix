# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:
  let 
    awesomescript = import ./my-awesome-script.nix {inherit pkgs;};
    #restoretmux = import ./restoretmux.nix {inherit pkgs;};
  in

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #../i3.nix
      ../sway.nix
      #../nvidia.nix
      ../nvidia
      #../nvidia/disable.nix
      ##../hyprland.nix
      #../vm.nix
      ../intel
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


  # Enable CUPS to print documents.
  services.printing.enable = true;


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


  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault false;
  networking.interfaces.wlp0s20f3.useDHCP = true;
  # networking.interfaces.wwan0.useDHCP = lib.mkDefault true;
  networking.interfaces.enp0s31f6.ipv4.addresses = [ {
    address = "192.168.10.95";
    prefixLength = 24;
  } ];

  networking.nameservers = [ "1.1.1.1" "9.9.9.9" "8.8.8.8" ];
  #networking.nameservers = [ "192.168.2.50" "1.1.1.1" "9.9.9.9." "8.8.8.8" ];

  #networking.dhcpcd.extraConfig = "nohook resolv.conf"; #needed for pihole
    # If using NetworkManager:
  #networking.networkmanager.dns = "none"; # needed for pihole
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
    kitty
    kitty-themes
    zsh
    #picom
    gparted
    brightnessctl
    acpilight
    auto-cpufreq
    awesomescript
    xorg.xhost
    #restoretmux
    brillo
  ];

  hardware.brillo.enable = true;

  documentation.enable = true;
  documentation.man.enable = true;
  documentation.dev.enable = true;

  #services.auto-cpufreq.enable = true;

  # programs.light.enable = true;
  # xev keycode have to be substracted with 8

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

  
  # nixpkgs.config.pulseaudio = true;
  # hardware.pulseaudio.enable = true;

  sound.enable = true;

  #rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  programs.neovim.defaultEditor = true;

  environment.variables = { EDITOR = "vi"; };


  environment.shells = with pkgs; [ zsh ];

  # console = {
    #font = "Lat2-Terminus16";
    # font = "FiraCode";
    #keyMap = "us";
  # 	  useXkbConfig = true;
  # };


  # fonts.packages = with pkgs; [
  #   fira-code
  #   fira-code-symbols
  #   #cantarell-fonts
  #   #font-awesome_5
  #   #font-awesome_4
  #   #font-awesome
  #   #(nerdfonts.override { fonts = [ "FiraCode" "NerdFontsSymbolsOnly" ]; })
  #   (nerdfonts.override { fonts = [ "FiraCode" ]; })
  # ];

  fonts.packages = with pkgs; [
    font-awesome_5
    cantarell-fonts
    fira-code
    fira-code-symbols
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" "NerdFontsSymbolsOnly" ]; })

  ];

  services.openssh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };



  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";
	};

  #myString = "${pkgs.tmuxPlugins.re
  #environment.etc."testtest".source = "${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/restore.sh";

  # Enable OpenGL
  # hardware.opengl = {
  #   enable = true;
  #   driSupport = true;
  #   driSupport32Bit = true;
  # };

  # hardware.opengl.extraPackages = with pkgs; [
  #   vaapiVdpau # for nvidia
  #   #vaapiIntel   #older then 23.11
  #   libvdpau-va-gl
  #   intel-media-driver
  #   intel-vaapi-driver
  # ];

  #hardware.nvidia.modesetting.enable = true;
  #services.xserver.videoDrivers  = [ "nvidia" ];
  #services.xserver.videoDrivers = ["intel"];


  # Load nvidia driver for Xorg and Wayland
  #services.xserver.videoDrivers = ["nvidia"];
  #services.xserver.videoDrivers = ["nouveau"];
  #programs.hyprland.enable = true;
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelParams = [ "i915.force_probe=25b9" ];

  #boot.kernelPackages = pkgs.linuxPackages_5_15;

  # needed for gtk
  programs.dconf.enable = true;

  #boot.initrd.kernelModules = [ "i915" ];

  # environment.variables = {
  #   VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  # };





}

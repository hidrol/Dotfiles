{ config, pkgs, ... }:
{
  #environment.systemPackages = [ unstable.neovim ];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvim.nix
    #<home-manager/nixos> 
  ];

#  boot.loader.grub.device = "/dev/sda";   # (for BIOS systems only)
  boot.loader.systemd-boot.enable = true; # (for UEFI systems only)




  # Enable the OpenSSH server.
  services.sshd.enable = true;

  networking.networkmanager.enable = true;
  networking.hostName = "nixos";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;

  users.users.hidrol = {
    isNormalUser = true;
    home = "/home/hidrol";
    extraGroups = [ "wheel" "networkmanager" "lxd" ];
    shell = pkgs.zsh;
  };

  #home-manager.users.hidrol = { pkgs, ... }: {
    #home.stateVersion = "22.11";
    #home.packages = [];
    #imports = [
      #/home/hidrol/Dotfiles/home.nix
    #];
  #};

  nixpkgs.config.allowUnfree = true;

#hardware.xone.enable = true;
  hardware.xpadneo.enable = true;
#services.hardware.xow.enable = true;

  virtualisation.lxd.enable = true;

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
    #vifm
    #gdb
    #python3
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
  ];


  programs.tmux = {
    enable = true;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [ 
      resurrect 
      continuum
    ];
    #   plugins = with pkgs.tmuxPlugins; [{
    #      plugin = resurrect;
    #      extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    #    }];
    #clock24 = true;
    #extraConfig = ''
      #source /home/hidrol/Dotfiles/tmux.conf
    #'';
  };

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




# Set console.
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

# Set your time zone.
  time.timeZone = "Europe/Berlin";

# The global useDHCP flag is deprecated, therefore explicitly set to false here.
# Per-interface useDHCP will be mandatory in the future, so this generated config
# replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;

  services.xserver.enable  = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.defaultSession  = "none+i3";
  services.xserver.layout  = "us";
  services.xserver.displayManager.lightdm.enable  = true;
  services.xserver.displayManager.autoLogin.enable  = true;
  services.xserver.displayManager.autoLogin.user  = "hidrol";
  services.xserver.xkbOptions = "ctrl:swapcaps";

  #services.xserver.videoDrivers  = [ "nvidia" ];
#hardware.opengl.enable = true;

# Optionally, you may need to select the appropriate driver version for your specific GPU.
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  boot.kernelPackages = pkgs.linuxPackages_5_10;

#  boot.kernelParams = [ "module_blacklist=i915" ];

#services = {
#  fstrim.enable = true;
#  openssh.enable = true;
#  xserver.enable = true;
    #compton.enable = true;
    #compton.shadow = true;
#  compton.inactiveOpacity = "0.8";
#  printing.enable = true;
#};


  #system.stateVersion = "22.05";
  system.stateVersion = "22.11";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
  };

}

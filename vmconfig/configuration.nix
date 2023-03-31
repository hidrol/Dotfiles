{ config, pkgs, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  #environment.systemPackages = [ unstable.neovim ];

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvim.nix
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

  nixpkgs.config.allowUnfree = true;

  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 10"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 10"; }
    ];
  };

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
    tmux 
    joplin-desktop
    nextcloud-client
    ccls
    ctags
    htop
    usbutils
    firefox
    xclip
    gcc
    libusb
    picom
    gparted
    vifm
    lshw
    pciutils
    #lsof see which process is running on device
    cpufrequtils
    #lxd
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
    nvidia-offload
    powertop
    acpi
    lm_sensors
    xorg.xev # see keycodes
    ntfs3g
  ];

  #networking.wireless.userControlled.enable = true;

  #networking.wireless.enable = true;


  programs.tmux = {
    enable = true;
    baseIndex = 1;
    plugins = with pkgs.tmuxPlugins; [ resurrect ];
    #   plugins = with pkgs.tmuxPlugins; [{
    #      plugin = resurrect;
    #      extraConfig = "set -g @resurrect-strategy-nvim 'session'";
    #    }];
    #clock24 = true;
    extraConfig = ''
      source /home/hidrol/Dotfiles/tmux.conf
    '';
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
  networking.interfaces.ens33.useDHCP = true;
  #networking.interfaces.wlo1.useDHCP = true;

  services.xserver.enable  = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.defaultSession  = "none+i3";
  services.xserver.layout  = "us";
  services.xserver.displayManager.lightdm.enable  = true;
  services.xserver.displayManager.autoLogin.enable  = true;
  services.xserver.displayManager.autoLogin.user  = "hidrol";
  services.xserver.xkbOptions = "ctrl:swapcaps";
# needed by touchpad victus
 services.xserver.libinput.touchpad.naturalScrolling = true;
 services.xserver.libinput.touchpad.middleEmulation = true;
 services.xserver.libinput.touchpad.tapping = true;
 services.xserver.libinput.enable = true;
#
#hardware.nvidia.modesetting.enable = true;
#services.xserver.videoDrivers  = [ "nvidia" ];
#hardware.opengl.enable = true;


# Optionally, you may need to select the appropriate driver version for your specific GPU.
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  #boot.kernelParams = [ "module_blacklist=i915" ];

  #boot.kernelParams = [ "module_blacklist=i915" ];



  #system.stateVersion = "22.05";
  system.stateVersion = "latest";
  #environment.systemPackages = [ nvidia-offload ];

  #hardware.nvidia.prime = {
    #offload.enable = true;
  
    # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
    #intelBusId = "PCI:0:2:0";
  
    # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
    #nvidiaBusId = "PCI:1:0:0";
  #};

  #specialisation = {
    #external-display.configuration = {
      #services.xserver.videoDrivers  = [ "nvidia" ];
      #services.logind.lidSwitch = "ignore";
      #system.nixos.tags = [ "external-display" ];
      #hardware.nvidia.modesetting.enable = pkgs.lib.mkForce false;
      #hardware.nvidia.prime.offload.enable = pkgs.lib.mkForce false;
      #hardware.nvidia.powerManagement.enable = pkgs.lib.mkForce false;
      # hardware.nvidia.prime.offload.enable = false;
      # hardware.nvidia.powerManagement.enable = false;
    #};
  #};

  #powerManagement = { 
        #enable = true; 
        #cpuFreqGovernor = "powersave"; 
   #};
   #powerManagement.powertop.enable = true;
   #services.thermald.enable = true;

   #boot.kernelModules = [ "coretemp" "cpuid" ];
  virtualisation.vmware.guest.enable = true;

}


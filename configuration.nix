# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      #../nvidia/disable.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

	services.xserver.displayManager.gdm.enable = true;
	services.xserver.enable = true;
	services.xserver.desktopManager.gnome.enable = true;

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




  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hidrol = {
    isNormalUser = true;
    description = "hidrol";
    extraGroups = [ "networkmanager" "wheel" ];
    #extraGroups = [ "wheel" "networkmanager" "lxd" "docker" "video" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
	chromium
	joplin-desktop
    #  thunderbird
    ];
  };

  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    kitty
    zsh
	neovim
  ];




  programs.zsh = {
    enable = true;
  };


  environment.shells = with pkgs; [ zsh ];

  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Did you read the comment?

	nix = {
		package = pkgs.nixFlakes;
		extraOptions = "experimental-features = nix-command flakes";
	};

#services.xserver.videoDrivers = [ "modesetting" ];
# NixOS docs suggest this.
#services.xserver.useGlamor = true;

#boot.kernelParams = [
    #"i915.enable_psr=1"
    # For Power consumption
    # https://kvark.github.io/linux/framework/2021/10/17/framework-nixos.html
    #mem_sleep_default=deep"
    # For Power consumption
    # https://community.frame.work/t/linux-battery-life-tuning/6665/156
    #nvme.noacpi=1"
#];

#services.fwupd.enable = true;

#hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

#boot.initrd.kernelModules = [ "i915" ];

#  environment.variables = {
#    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
#  };

#  hardware.opengl.extraPackages = with pkgs; [
#    (if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then vaapiIntel else intel-vaapi-driver)
#    libvdpau-va-gl
#    intel-media-driver
#  ];

# intel gpu disable
  #boot.blacklistedKernelModules = lib.mkDefault [ "i915" ];
  # KMS will load the module, regardless of blacklisting
  #boot.kernelParams = lib.mkDefault [ "i915.modeset=0" ];
#####

boot.kernelParams = [
    # For Power consumption
    # https://kvark.github.io/linux/framework/2021/10/17/framework-nixos.html
    "mem_sleep_default=deep"
    # Workaround iGPU hangs
    # https://discourse.nixos.org/t/intel-12th-gen-igpu-freezes/21768/4
    "i915.enable_psr=1"
  ];

  boot.blacklistedKernelModules = [ 
    # This enables the brightness and airplane mode keys to work
    # https://community.frame.work/t/12th-gen-not-sending-xf86monbrightnessup-down/20605/11
    "hid-sensor-hub"
    # This fixes controller crashes during sleep
    # https://community.frame.work/t/tracking-fn-key-stops-working-on-popos-after-a-while/21208/32
    "cros_ec_lpcs"
  ];
  
  # Further tweak to ensure the brightness and airplane mode keys work
  # https://community.frame.work/t/responded-12th-gen-not-sending-xf86monbrightnessup-down/20605/67
  systemd.services.bind-keys-driver = {
    description = "Bind brightness and airplane mode keys to their driver";
    wantedBy = [ "default.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    script = ''
      ls -lad /sys/bus/i2c/devices/i2c-*:* /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-*:*
      if [ -e /sys/bus/i2c/devices/i2c-FRMW0001:00 -a ! -e /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-FRMW0001:00 ]; then
        echo fixing
        echo i2c-FRMW0001:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/bind
        ls -lad /sys/bus/i2c/devices/i2c-*:* /sys/bus/i2c/drivers/i2c_hid_acpi/i2c-*:*
        echo done
      else
        echo no fix needed
      fi
    '';
  };

  # Alder Lake CPUs benefit from kernel 5.18 for ThreadDirector
  # https://www.tomshardware.com/news/intel-thread-director-coming-to-linux-5-18
  boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "5.18") (lib.mkDefault pkgs.linuxPackages_latest);

   hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

boot.initrd.kernelModules = [ "i915" ];

  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };

  hardware.opengl.extraPackages = with pkgs; [
    (if (lib.versionOlder (lib.versions.majorMinor lib.version) "23.11") then vaapiIntel else intel-vaapi-driver)
    libvdpau-va-gl
    intel-media-driver
  ];









}

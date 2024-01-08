# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, ... }:

{
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

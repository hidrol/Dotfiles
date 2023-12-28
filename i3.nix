{ config, pkgs, lib, ... }:
{
  #hardware.pulseaudio.enable = true;
  #nixpkgs.config.pulseaudio = true;
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "hidrol";
  services.xserver.enable  = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.displayManager.defaultSession  = "none+i3";
  services.xserver.layout  = "us";
  services.xserver.displayManager.lightdm.enable  = true;
  services.xserver.xkbOptions = "ctrl:swapcaps";
  services.xserver.libinput.touchpad.naturalScrolling = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  environment.systemPackages = with pkgs; [
    picom
  ];
  services.xserver.videoDrivers = ["nvidia"];
  #services.xserver.videoDrivers = ["nouveau"];

  services.actkbd = {
    enable = true;
    bindings = [
      # brightness
      # { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/xbacklight -dec 5"; }
      # { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/xbacklight -inc 5"; }

      { keys = [ 224 ]; events = [ "key" ]; command = "${pkgs.brillo}/bin/brillo -q -U 3"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "${pkgs.brillo}/bin/brillo -q -A 3"; }

      #{ keys = [ 121 ]; events = [ "key" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master toggle"; }

      # "Lower Volume" media key
      # { keys = [ 60 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}- unmute"; }

      # "Raise Volume" media key
      #{ keys = [ 61 ]; events = [ "key" "rep" ]; command = "${pkgs.alsaUtils}/bin/amixer -q set Master ${config.sound.mediaKeys.volumeStep}+ unmute"; }
      # { keys = [ 60 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/amixer Master 8%-"; }
      # { keys = [ 61 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/amixer Master 8%+"; }
      # { keys = [ 61 ]; events = [ "key" "rep" ]; command = "${pkgs.alsa-utils}/bin/amixer set Master toggle"; }
      #  { keys = [ 224 ]; events = [ "key" ]; command = "${pkgs.alsa-utils}/bin/amixer set Master 3%+"; }
      #  { keys = [ 225 ]; events = [ "key" ]; command = "${pkgs.alsa-utils}/bin/amixer set Master 3%-"; }
      # { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l hidrol -c 'amixer -q set Master 5%- unmute'"; }
      # { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/runuser -l hidrol -c 'amixer -q set Master 5%+ unmute'"; }

        # "XF86AudioMute" = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
        # "XF86AudioRaiseVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 3%+";
        # "XF86AudioLowerVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 3%-";
        # "XF86MonBrightnessUp" = "exec ${pkgs.brillo}/bin/brillo -q -A 3";
        # "XF86MonBrightnessDown" = "exec ${pkgs.brillo}/bin/brillo -q -U 3";

    ];
  };
}

{ config, pkgs, lib, ... }:
{
  hardware.pulseaudio.enable = true;
  nixpkgs.config.pulseaudio = true;
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
}

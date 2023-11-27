{ config, pkgs, lib, ... }:
{
  #programs.sway.enable = true;

  # audio
  sound.enable = true;
  #nixpkgs.config.pulseaudio = true;
  #hardware.pulseaudio.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  security.polkit.enable = true;

  programs.light.enable = true;

  # environment.loginShellInit = ''
  #   [[ "$(tty)" == /dev/tty? ]] && sudo /run/current-system/sw/bin/lock this 
  #   [[ "$(tty)" == /dev/tty1 ]] && sway --unsupported-gpu
  # '';
  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty? ]] && sudo /run/current-system/sw/bin/lock this 
    [[ "$(tty)" == /dev/tty1 ]] && sway 
  '';


  services.actkbd = {
    enable = true;
    bindings = [
      # brightness
      # { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/xbacklight -dec 5"; }
      # { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/xbacklight -inc 5"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 3"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 3"; }

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

  environment.systemPackages = with pkgs; [
    kanshi
    bemenu
    wl-clipboard
  ];



  #services.xserver.displayManager.gdm.wayland = false;
}

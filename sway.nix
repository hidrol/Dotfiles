{ config, pkgs, lib, ... }:

let
  # bash script to let dbus know about important env variables and
  # propagate them to relevent services run at the end of sway config
  # see
  # https://github.com/emersion/xdg-desktop-portal-wlr/wiki/"It-doesn't-work"-Troubleshooting-Checklist
  # note: this is pretty much the same as  /etc/sway/config.d/nixos.conf but also restarts  
  # some user services to make sure they have the correct environment variables
  dbus-sway-environment = pkgs.writeTextFile {
    name = "dbus-sway-environment";
    destination = "/bin/dbus-sway-environment";
    executable = true;

    text = ''
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
      systemctl --user stop pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
      systemctl --user start pipewire pipewire-media-session xdg-desktop-portal xdg-desktop-portal-wlr
    '';
  };

  # currently, there is some friction between sway and gtk:
  # https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland
  # the suggested way to set gtk settings is with gsettings
  # for gsettings to work, we need to tell it where the schemas are
  # using the XDG_DATA_DIR environment variable
  # run at the end of sway config
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };


in
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
  # environment.loginShellInit = ''
  #   [[ "$(tty)" == /dev/tty? ]] && sudo /run/current-system/sw/bin/lock this 
  #   [[ "$(tty)" == /dev/tty1 ]] && sway 
  # '';




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

  # environment.systemPackages = with pkgs; [
  #   kanshi
  #   bemenu
  # ];

  environment.systemPackages = with pkgs; [
    kanshi
    alacritty # gpu accelerated terminal
    dbus-sway-environment
    configure-gtk
    wayland
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors
    swaylock
    swayidle
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    #bemenu # wayland clone of dmenu
    mako # notification system developed by swaywm maintainer
    wdisplays # tool to configure displays
  ];

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    # gtk portal needed to make gtk apps happy
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  #services.xserver.videoDrivers = ["nvidia"];
  services.xserver.videoDrivers = ["nouveau"];

  # enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export _JAVA_AWT_WM_NONREPARENTING=1
      export MOZ_ENABLE_WAYLAND=1
    '';
  };



  #services.xserver.displayManager.gdm.wayland = false;
}

{ pkgs, lib, ... }:
{
  imports = [./waybar];

  programs.wofi = {
    enable = true;
    #style = builtins.readFile ./style.css;
  };

  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
  ];

  wayland.windowManager.sway = {
    enable = true;
    extraConfig = ''
      default_border none

      input type:touchpad {
          tap enabled
          natural_scroll enabled
      }
      input "type:keyboard" {
        xkb_options ctrl:swapcaps
        repeat_delay 250
        repeat_rate 30

      }

      exec_always kanshi

      bar { 
        swaybar_command waybar
      }

      #smart_boarders on

    '';
      # output "Dell Inc. DELL P2419H 5VH1MV2" position 0 0
      # output eDP-1 disable 
    config = rec {
      bars = [];
      modifier = "Mod4";
      # Use kitty as default terminal
      terminal = "kitty"; 
      keybindings = lib.mkOptionDefault {
        # Use selected XF86 keyboard symbols
        "XF86AudioMute" = "exec ${pkgs.alsa-utils}/bin/amixer set Master toggle";
        "XF86AudioRaiseVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 3%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 3%-";
        "XF86MonBrightnessUp" = "exec ${pkgs.brillo}/bin/brillo -q -A 3";
        "XF86MonBrightnessDown" = "exec ${pkgs.brillo}/bin/brillo -q -U 3";
        "${modifier}+Shift+o" = "move workspace to output left";
        "${modifier}+Shift+p" = "move workspace to output right";
        "${modifier}+d" = "exec ${pkgs.wofi}/bin/wofi --show=drun --allow-images --insensitive";
      };
      #startup = [
        # Launch Firefox on start
        #{
          #command = "exec_always kanshi;";
        #}
      #];
      window.border = 0;
    };
  };

  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };


   gtk = {
    enable = true;
    theme = {
      package = pkgs.gnome.gnome-themes-extra;
      name = "Adwaita-dark";
    };
     cursorTheme = {
       name = "Adwaita";
     };
   };
  
  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
  };



}

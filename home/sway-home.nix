{ pkgs, lib, ... }:
{
  imports = [./waybar.nix];

  programs.wofi = {
    enable = true;
    #style = builtins.readFile ./style.css;
  };

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

      #smart_boarders on
      bar { 
        swaybar_command waybar
      }

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
        "XF86AudioRaiseVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 8%+";
        "XF86AudioLowerVolume" = "exec ${pkgs.alsa-utils}/bin/amixer set Master 8%-";
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

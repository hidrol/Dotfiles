{ pkgs, lib, ... }:
{
  #imports = [./home/waybar.nix];

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
      set $menu bemenu-run

      exec_always kanshi

      #smart_boarders on

    '';
      # output "Dell Inc. DELL P2419H 5VH1MV2" position 0 0
      # output eDP-1 disable 
    config = rec {
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

{
  pkgs,
  config,
  ...
}: {

  imports = [
    ./special.nix
  ];

  config = {
    programs.waybar = {
      enable = true;
      #systemd.enable = true;

      settings = [
        {
            "layer"= "top"; # Waybar at top layer
            "position"= "top"; # Waybar position (top|bottom|left|right)
            # "height"= 36; // Waybar height (to be removed for auto height)
            # Archived modules
            # "custom/gpu", "bluetooth",  "custom/weather", "temperature", "sway/window"
            # Choose the order of the modules
            # "modules-left"= [ "clock" "sway/language" "custom/scratchpad-indicator" "custom/pacman" "sway/mode" "idle_inhibitor" "custom/media"];
            # my stuff
            "modules-left"= [ "clock" "sway/language"  "sway/mode" "idle_inhibitor" ];
            "modules-center"= ["sway/workspaces"];
            # "modules-right"= [ "custom/cpugovernor" "cpu" "temperature" "custom/gpu" "pulseaudio" "bluetooth" "network" "tray"];
            #my modules
            "modules-right"= [  "cpu"  "pulseaudio" "network" "tray" "battery" ];
            # Modules configuration
            "sway/workspaces" = {
                "disable-scroll" = true;
                "all-outputs"= true;
                "format"= "{icon}";
                "format-icons"= {
                    #"1"= "<span color=\"#D8DEE9\"></span>";
                    "1"= "<span color=\"#${config.colorScheme.colors.base0B}\"></span>";
                    "2"= "<span color=\"#${config.colorScheme.colors.base0D}\"></span>";
                    #"2"= "<span color=\"#88C0D0\"></span>";
                    "3"= "<span color=\"#${config.colorScheme.colors.base0B}\"></span>";
                    #"3"= "<span color=\"#A3BE8C\"></span>";
                    "4"= "<span color=\"#${config.colorScheme.colors.base04}\"></span>";
                    #"4"= "<span color=\"#D8DEE9\"></span>";
                    "urgent"= "";
                    # "focused"= "";
                    "default"= "";
# set $ws1 "1:"
# set $ws2 "2:"
# set $ws3 "3:"
# set $ws4 "4:"
# set $ws5 "5:"
                };
            };
            "sway/mode"= {
                "format"= "<span style=\"italic\">{}</span>";
            };
            "sway/window"= {
                "format"= "{}";
                "max-length"= 50; 
                "tooltip"= false;
            };
            # "bluetooth"= {
            #     "interval"= 30;
            #     "format"= "{icon}";
            #     # "format-alt"= "{status}";
            #     "format-icons"= {
            #         "enabled"= "";
            #         "disabled"= "";
            #     };
            #     "on-click"= "blueberry";
            # };    
            "sway/language"= {
                "format"= "<big></big> {}";
                "max-length"= 5;
                "min-length"= 5;        
            };
            "idle_inhibitor"= {
                "format"= "{icon}";
                "format-icons"= {
                    "activated"= " ";
                    "deactivated"= " ";
                };
                "tooltip"= "true";
            };
            "tray"= {
                #"icon-size"= 11,
                "spacing"= 5;
            };
            "clock"= {
                "format"= "  {:%H:%M    %e %b}";
                "tooltip-format"= "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                "today-format"= "<b>{}</b>";
                "on-click"= "gnome-calendar";
            };
            "cpu"= {
                "interval"= "1";      
                "format"= "   {max_frequency}GHz <span color=\"darkgray\">| {usage}%</span>";
                "max-length"= 13;
                "min-length"= 13;
                "on-click"= "kitty -e htop --sort-key PERCENT_CPU";
                "tooltip"= false;
            };
            # "temperature"= {
            #     #"thermal-zone"= 1;
            #     "interval"= "4";
            #     "hwmon-path"= "/sys/class/hwmon/hwmon3/temp1_input";
            #     "critical-threshold"= 74;
            #     "format-critical"= "  {temperatureC}°C";
            #     "format"= "{icon}  {temperatureC}°C";
            #     "format-icons"= ["" "" ""];
            #     "max-length"= 7;
            #     "min-length"= 7;
            # };
            "network"= {
                # "interface"= "wlan0", // (Optional) To force the use of this interface,
                "format-wifi"= "  {essid}";
                "format-ethernet"= "{ifname}: {ipaddr}/{cidr} ";
                "format-linked"= "{ifname} (No IP) ";
                "format-disconnected"= "";
                "format-alt"= "{ifname}: {ipaddr}/{cidr}";
                "family"= "ipv4";
                "tooltip-format-wifi"= "  {ifname} @ {essid}\nIP: {ipaddr}\nStrength: {signalStrength}%\nFreq: {frequency}MHz\n {bandwidthUpBits}  {bandwidthDownBits}";
                "tooltip-format-ethernet"= " {ifname}\nIP: {ipaddr}\n {bandwidthUpBits}  {bandwidthDownBits}";
            };
            "pulseaudio"= {
                "scroll-step"= 3; # %, can be a float
                "format"= "{icon} {volume}% {format_source}";
                "format-bluetooth"= "{volume}% {icon} {format_source}";
                "format-bluetooth-muted"= " {icon} {format_source}";
                "format-muted"= " {format_source}";
                #"format-source"= "{volume}% ";
                #"format-source-muted"= "";
                "format-source"= "";
                "format-source-muted"= "";
                "format-icons"= {
                    "headphone"= "";
                    "hands-free"= "";
                    "headset"= "";
                    "phone"= "";
                    "portable"= "";
                    "car"= "";
                    "default"= ["" "" ""];
                };
                "on-click"= "pavucontrol";
                "on-click-right"= "pactl set-source-mute @DEFAULT_SOURCE@ toggle";
            };
            # "custom/pacman"= {
            #     "format"= "<big>􏆲</big>  {}";
            #     "interval"= 3600;                     # every hour
            #     "exec"= "checkupdates | wc -l";       # # of updates
            #     "exec-if"= "exit 0";                  # always run; consider advanced run conditions
            #     "on-click"= "kitty -e 'yay'; pkill -SIGRTMIN+8 waybar"; # update system
            #     "signal"= 8;
            #     "max-length"= 5;
            #     "min-length"= 3;
            # };
            "custom/weather"= {
                "exec"= "curl 'https://wttr.in/?format=1'";
                "interval"= 3600;
            };
            # "custom/gpu"= {
            #   "exec"= "$HOME/.config/waybar/custom_modules/custom-gpu.sh";
            #   "return-type"= "json";
            #   "format"= "  {}";
            #   "interval"= 2;
            #   "tooltip"= "{tooltip}";
            #   "max-length"= 19;
            #   "min-length"= 19;
            #   "on-click"= "powerupp";
            #  
            # }; 
            # "custom/cpugovernor"= {
            #   "format"= "{icon}";
            #   "interval"= "30";
            #   "return-type"= "json";
            #   "exec"= "$HOME/.config/waybar/custom_modules/cpugovernor.sh";
            #   "min-length"= 2;
            #   "max-length"= 2;
            #     "format-icons"= {
            #         "perf"= "";
            #         "sched"= "";
            #     };
            # };    
            # "custom/media"= {
            #     "format"= "{icon} {}";
            #     "return-type"= "json";
            #     "max-length"= 40;
            #     "format-icons"= {
            #         "spotify"= "";
            #         "default"= "🎜";
            #     };
            #     "escape"= true;
            #     "exec"= "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
            #     # "exec"= "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
            # };
            # "custom/scratchpad-indicator"= {
            #     "interval"= 3;
            #     "return-type"= "json";
            #     "exec"= "swaymsg -t get_tree | jq --unbuffered --compact-output '( select(.name == \"root\") | .nodes[] | select(.name == \"__i3\") | .nodes[] | select(.name == \"__i3_scratch\") | .focus) as $scratch_ids | [..  | (.nodes? + .floating_nodes?) // empty | .[] | select(.id |IN($scratch_ids[]))] as $scratch_nodes | { text: \"\\($scratch_nodes | length)\", tooltip: $scratch_nodes | map(\"\\(.app_id // .window_properties.class) (\\(.id)): \\(.name)\") | join(\"\\n\") }'";
            #     "format"= "{} 􏠜";
            #     "on-click"= "exec swaymsg 'scratchpad show'";
            #     "on-click-right"= "exec swaymsg 'move scratchpad'";
            # };    

            battery = {
            states.critical = 10;
            format = "{capacity}% {icon}";
            format-charging = "{capacity}%  ";
            format-plugged = "{capacity}%  ";
            format-alt = "{time} {icon}";
            format-icons = [" " " " " " " " " "];
          };
        }
];
 #style = builtins.readFile ./style.css;
 style = ''

@keyframes blink-warning {
    70% {
        color: @light;
    }

    to {
        color: @light;
        background-color: @warning;
    }
}

@keyframes blink-critical {
    70% {
      color: @light;
    }

    to {
        color: @light;
        background-color: @critical;
    }
}


/* -----------------------------------------------------------------------------
 * Styles
 * -------------------------------------------------------------------------- */

/* COLORS */

/* Nord */
@define-color bg #${config.colorScheme.colors.base00};
/*@define-color bg #353C4A;*/
@define-color light #${config.colorScheme.colors.base04};
/*@define-color dark @nord_dark_font;*/
@define-color warning #${config.colorScheme.colors.base0A};
@define-color critical #${config.colorScheme.colors.base08};
@define-color mode #${config.colorScheme.colors.base02};
/*@define-color workspaces @bg;*/
/*@define-color workspaces @nord_dark_font;*/
/*@define-color workspacesfocused #${config.colorScheme.colors.base02};*/
@define-color workspacesfocused #${config.colorScheme.colors.base03};
@define-color tray @workspacesfocused;
@define-color sound #${config.colorScheme.colors.base0A};
@define-color network #${config.colorScheme.colors.base02};
@define-color memory #${config.colorScheme.colors.base02};
@define-color cpu #${config.colorScheme.colors.base02};
@define-color temp #${config.colorScheme.colors.base02};
@define-color layout #${config.colorScheme.colors.base0F};
@define-color battery #${config.colorScheme.colors.base02};
@define-color date #${config.colorScheme.colors.base02};
@define-color time #${config.colorScheme.colors.base02};
@define-color backlight #${config.colorScheme.colors.base02};
@define-color nord_bg #${config.colorScheme.colors.base02};
@define-color nord_bg_blue #${config.colorScheme.colors.base02};
@define-color nord_light #${config.colorScheme.colors.base04};
@define-color nord_light_font #${config.colorScheme.colors.base04};
@define-color nord_dark_font #${config.colorScheme.colors.base02};

/* Reset all styles */
* {
    border: none;
    border-radius: 3px;
    min-height: 0;
    margin: 0.2em 0.3em 0.2em 0.3em;
}

/* The whole bar */
#waybar {
    background: @bg;
    color: @light;
    font-family: "Cantarell", "Font Awesome 5 Pro";
    font-size: 12px;
    font-weight: bold;
}

/* Each module */
#battery,
#clock,
#cpu,
#custom-layout,
#memory,
#mode,
#network,
#pulseaudio,
#temperature,
#custom-alsa,
#custom-pacman,
#custom-weather,
#custom-gpu,
#tray,
#backlight,
#language,
#custom-cpugovernor {
    padding-left: 0.6em;
    padding-right: 0.6em;
}

/* Each module that should blink */
#mode,
#memory,
#temperature,
#battery {
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

/* Each critical module */
#memory.critical,
#cpu.critical,
#temperature.critical,
#battery.critical {
    color: @critical;
}

/* Each critical that should blink */
#mode,
#memory.critical,
#temperature.critical,
#battery.critical.discharging {
    animation-name: blink-critical;
    animation-duration: 2s;
}

/* Each warning */
#network.disconnected,
#memory.warning,
#cpu.warning,
#temperature.warning,
#battery.warning {
    background: @warning;
    color: @nord_dark_font;
}

/* Each warning that should blink */
#battery.warning.discharging {
    animation-name: blink-warning;
    animation-duration: 3s;
}

/* And now modules themselves in their respective order */

#mode { /* Shown current Sway mode (resize etc.) */
    color: @light;
    background: @mode;
}

/* Workspaces stuff */

#workspaces {
 /*   color: #${config.colorScheme.colors.base04};
    margin-right: 10px;*/
}

#workspaces button {
    font-weight: bold; /* Somewhy the bar-wide setting is ignored*/
    padding: 0;
    /*color: #999;*/
    opacity: 0.3;
    background: none;
    font-size: 1em;
}

#workspaces button.focused {
    background: @workspacesfocused;
    color: #${config.colorScheme.colors.base04};
    opacity: 1;
    padding: 0 0.4em;
}

#workspaces button.urgent {
    border-color: #c9545d;
    color: #c9545d;
    opacity: 1;
}

#window {
    margin-right: 40px;
    margin-left: 40px;
    font-weight: normal;
}
#bluetooth {
    background: @nord_bg_blue;
    font-size: 1.2em;
    font-weight: bold;
    padding: 0 0.6em;
}
#custom-gpu {
    background: @nord_bg;
    font-weight: bold;
    padding: 0 0.6em;
}
#custom-weather {
    background: @mode;
    font-weight: bold;
    padding: 0 0.6em;
}
#custom-pacman {
    background: @nord_light;
    color: @nord_dark_font;
    font-weight: bold;
    padding: 0 0.6em;
}
#custom-scratchpad-indicator {
    background: @nord_light;
    color: @nord_dark_font;
    font-weight: bold;
    padding: 0 0.6em;
}
#idle_inhibitor {
    background: @mode;
    /*font-size: 1.6em;*/
    font-weight: bold;
    padding: 0 0.6em;
}
#custom-alsa {
    background: @sound;
}

#network {
    background: @nord_bg_blue;
}

#memory {
    background: @memory;
}

#cpu {
    background: @nord_bg;
    color: #${config.colorScheme.colors.base04};
}
#cpu.critical {
    color: @nord_dark_font;
}
#language {
    background: @nord_bg_blue;
    color: #${config.colorScheme.colors.base04};
    padding: 0 0.4em;
}
#custom-cpugovernor {
    background-color: @nord_light;
    color: @nord_dark_font;
}
#custom-cpugovernor.perf {
    
}
#temperature {
    background-color: @nord_bg;
    color: #${config.colorScheme.colors.base04};
}
#temperature.critical {
    background:  @critical;
}
#custom-layout {
    background: @layout;
}

#battery {
    background: @battery;
}

#backlight {
    background: @backlight;
}

#clock {
    background: @nord_bg_blue;
    color: #${config.colorScheme.colors.base04};
}
#clock.date {
    background: @date;
}

#clock.time {
    background: @mode;
}

#pulseaudio { /* Unsused but kept for those who needs it */
    background: @nord_bg_blue;
    color: #${config.colorScheme.colors.base04};
}

#pulseaudio.muted {
    background: #BF616A;
    color: #BF616A;
    /* No styles */
}
#pulseaudio.source-muted {
    background: #D08770;
    color: #${config.colorScheme.colors.base04};
    /* No styles */
}
#tray {
    background: #434C5E;
}

 '';
    };
  };
}

{pkgs, config, ...}:
{
  home.file.".config/nixpkgs/home/waybar/style2.css".text = ''
    <color1>${config.colorScheme.colors.base00}</color1>



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
@define-color network #5D7096;
@define-color memory #546484;
@define-color cpu #596A8D;
@define-color temp #4D5C78;
@define-color layout #${config.colorScheme.colors.base0F};
@define-color battery #${config.colorScheme.colors.base0C};
@define-color date #${config.colorScheme.colors.base02};
@define-color time #${config.colorScheme.colors.base02};
@define-color backlight #${config.colorScheme.colors.base02};
@define-color nord_bg #${config.colorScheme.colors.base02};
@define-color nord_bg_blue #546484;
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
 /*   color: #D8DEE9;
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
    color: #D8DEE9;
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
    color: #D8DEE9;
}
#cpu.critical {
    color: @nord_dark_font;
}
#language {
    background: @nord_bg_blue;
    color: #D8DEE9;
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
    color: #D8DEE9;
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
    color: #D8DEE9;
}
#clock.date {
    background: @date;
}

#clock.time {
    background: @mode;
}

#pulseaudio { /* Unsused but kept for those who needs it */
    background: @nord_bg_blue;
    color: #D8DEE9;
}

#pulseaudio.muted {
    background: #BF616A;
    color: #BF616A;
    /* No styles */
}
#pulseaudio.source-muted {
    background: #D08770;
    color: #D8DEE9;
    /* No styles */
}
#tray {
    background: #434C5E;
}

'';

}


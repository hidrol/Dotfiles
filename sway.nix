{ config, pkgs, lib, ... }:
{
  #programs.sway.enable = true;

  # audio
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio.enable = true;

  security.polkit.enable = true;

  programs.light.enable = true;

  environment.loginShellInit = ''
    [[ "$(tty)" == /dev/tty? ]] && sudo /run/current-system/sw/bin/lock this 
    [[ "$(tty)" == /dev/tty1 ]] && sway --unsupported-gpu
  '';

  #services.xserver.displayManager.gdm.wayland = false;
}

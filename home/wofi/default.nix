
{ pkgs, lib, ... }:
{
  programs.wofi = {
    enable = true;
    style = builtins.readFile ./style.css;
  };
}

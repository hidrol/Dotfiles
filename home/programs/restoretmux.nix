{ pkgs, ...}:
   pkgs.writeShellScriptBin "restoretmux" '' 
     ${pkgs.tmuxPlugins.resurrect}/scripts/restore.sh
   ''


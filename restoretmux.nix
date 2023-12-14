{ pkgs, ...}:
   pkgs.writeShellScriptBin "restoretmux" '' 
     ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/scripts/restore.sh
   ''


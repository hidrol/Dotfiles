{ pkgs, ...}:
#   pkgs.writeShellScriptBin "my-awesome-script" '' 
#     echo "hello world" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
#   ''

pkgs.writeShellApplication {
  name = "my-awesome-script";
  runtimeInputs = [ pkgs.cowsay pkgs.lolcat ];
  text = ''
    echo "hello world" | cowsay | lolcat
    '';
}
    

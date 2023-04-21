{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    #nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };
  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
         desktop = lib.nixosSystem {
          inherit system pkgs;
          modules = [ ./desktop/configuration.nix ];
        };
        #<second user> = lib.nixosSystem {
        #inherit system;
        #modules = [ ./configuration.nix ];
        #};
      };
    };
}

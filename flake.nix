{
  inputs = {
    #other inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, home-manager, ... }:
    let
      #variables
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        desktop = lib.nixosSystem {
          inherit system;
          modules = [
            ./desktop/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.hidrol = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
    };
}

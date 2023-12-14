{
  inputs = {
    #other inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
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
      work_laptop = lib.nixosSystem {
        inherit system;
        modules = [
          ./work_laptop/configuration.nix
          ./greetd.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.hidrol = {
              imports = [ 
                ./home.nix 
                ./home/programs/gui.nix
                ./home/programs/no-gui.nix
                ./home/sway-home.nix 
              ];
            };
          }
        ];
      };
    };

    homeConfigurations = {
      hidrol = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ./home/programs/no-gui.nix ];
      };
    };
  };
}

{
  inputs = {
    #other inputs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    #variables
    system = "x86_64-linux";
    pkgs =nixpkgs.legacyPackages.${system};

  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
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
      work_laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        #specialArgs = { inherit inputs; };
        modules = [
          ./work_laptop/configuration.nix
          #./greetd.nix
        ];
      };
    };

    homeConfigurations = {
      hidrol = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; };
        modules = [ 
          ./home.nix 
          #./home/programs/gui.nix 
        ];
      };
    };
  };
}

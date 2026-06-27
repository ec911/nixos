{
  description = "wtf is a flake?";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    helium-flake.url = "github:oxcl/nix-flake-helium-browser";
     helium-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, helium-flake, ... }@inputs: {
    nixosConfigurations = {
      p53 = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          {
            environment.systemPackages = [
              helium-flake.packages.x86_64-linux.default
            ];
          }
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.eric = ./home.nix;
	    home-manager.backupFileExtension = "back";
	  }
        ];
      }; 
    };
  };
}

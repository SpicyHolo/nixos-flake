{
  description = "NixOS flake <3";
  
  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ...}: 
  {
    nixosConfigurations = { 
      nixos-holo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nixos # System module

          # Home module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs;
            home-manager.users.holo = import ./home;
          }
        ];
      };
    };
  };
}

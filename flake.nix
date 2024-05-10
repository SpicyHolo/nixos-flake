{
  description = "NixOS flake <3";
  
  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, spicetify-nix, ...}: 
  {
    nixosConfigurations = { 
      nixos-holo = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit spicetify-nix; };
        modules = [
          ./nixos # System module
          ./modules/spotify.nix # Spicetify module

          # Home module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = inputs
            home-manager.users.holo = import ./home;
          }
        ];
      };
    };
  };
}

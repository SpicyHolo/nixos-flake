{
  description = "NixOS flake <3";

  inputs = { 
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Manages user nix config
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # SDDM (desktop manager) theme
    sddm-sugar-candy-nix = {
      url = "gitlab:Zhaith-Izaliel/sddm-sugar-candy-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  
  outputs = inputs@{ self, nixpkgs, home-manager, sddm-sugar-candy-nix, ...}: 
  let 
    system = "x86_64-linux";
    user = "holo";
  in {
    nixosConfigurations = { 
      nixos-holo = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { 
          inherit inputs; 
          inherit system;
        };

        modules = [
          ./nixos # System module

          # Home module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.extraSpecialArgs = { 
              inherit inputs; 
              inherit system;
              inherit user;
            };
            home-manager.users.${user} = import ./home;
          }
        ];
      };
    };
  };
}



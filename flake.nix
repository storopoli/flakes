{
  description = "NixOS/MacOS Valhalla Configs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixpkgs-23.05-darwin";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs @ { self, nix-darwin, nixpkgs, nixpkgs-stable, home-manager, rust-overlay, agenix, ... }:
    {
      darwinConfigurations = {
        macbook = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            ./macbook
            {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
                agenix.overlays.default
              ];
            }
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.user = import ./macbook/home-manager;
              };
            }
            agenix.nixosModules.default
          ];
        };
        macbook_x86 = nix-darwin.lib.darwinSystem {
          system = "x86_64-darwin";
          specialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
                agenix.overlays.default
              ];
            }
            ./macbook
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.user = import ./macbook/home-manager;
              };
            }
            agenix.nixosModules.default
          ];
        };
      };
    };
}

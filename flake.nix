{
  description = "NixOS/MacOS Minimalist-Hardened-Privacy-oriented Configs";
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

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixos-flake.url = "github:srid/nixos-flake";
    rust-overlay.url = "github:oxalica/rust-overlay";
    agenix.url = "github:ryantm/agenix";
    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      imports = [
        inputs.nixos-flake.flakeModule
      ];

      perSystem = { config, inputs', pkgs, system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
          };
        in
        {
          devShells = {
            # run by `nix develop` or `nix-shell`(legacy)
            default = import ./shell.nix { inherit pkgs; };
          };

          formatter = pkgs.nixpkgs-fmt;
        };

      flake =
        let
          user = "user";
          hostname = "laptop";
          stateVersion = "23.11";
          darwinStateVersion = 4;
          homeStateVersion = "23.11";
        in
        {
          # Configurations for Linux (NixOS) machines
          nixosConfigurations = {
            framework = self.nixos-flake.lib.mkLinuxSystem {
              nixpkgs.hostPlatform = "x86_64-linux";
              imports = [
                self.nixosModules.common
                self.nixosModules.linux
                # Your home-manager configuration
                self.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.${user} = {
                      imports = [
                        self.homeModules.common
                        self.homeModules.linux
                        inputs.arkenfox.hmModules.default
                      ];
                      home.stateVersion = homeStateVersion;
                    };
                  };
                }
              ];
            };
          };

          # Configurations for macOS machines
          darwinConfigurations = {
            macbook = self.nixos-flake.lib.mkMacosSystem {
              nixpkgs.hostPlatform = "aarch64-darwin";
              imports = [
                self.nixosModules.common
                self.nixosModules.darwin
                # Your home-manager configuration
                self.darwinModules_.home-manager
                {
                  home-manager.users.${user} = {
                    imports = [
                      self.homeModules.common
                      self.homeModules.darwin
                    ];
                    home.stateVersion = homeStateVersion;
                  };
                }
              ];
            };
          };

          # All nixos/nix-darwin configurations are kept here.
          nixosModules = {
            # Common nixos/nix-darwin configuration shared between Linux and macOS.
            common = { pkgs, ... }: {
              imports = [
                # Custom inputs
                inputs.agenix.nixosModules.default
                {
                  nixpkgs.overlays = [
                    inputs.rust-overlay.overlays.default
                    inputs.agenix.overlays.default
                  ];
                }
                (import ./common)
              ];
            };
            # NixOS specific configuration
            linux = { pkgs, ... }: {
              imports = [
                # Custom inputs
                inputs.nur.nixosModules.nur
                inputs.impermanence.nixosModules.impermanence
                inputs.disko.nixosModules.disko
                (import ./linux)
              ];
              users.users.${user} = {
                # TODO: fix password with agenix
                initialHashedPassword =
                  "$6$MaOkIaWVTcGTX0Ec$5trnAnfzqMYsoggvBbjBcP.SPxx/B1fqsQxLfKU26QMerrG0QmRnaofCT3/K0LBk9aLeiPDjledO7Sdh9yv161";
                shell = pkgs.fish;
                isNormalUser = true;
                extraGroups =
                  [ "wheel" "docker" "libvirtd" "video" "audio" "networkmanager" ];
              };
              programs.fish.enable = true;
              networking.hostName = "${hostname}";
              system.stateVersion = "${stateVersion}";
              nix = {
                settings = { trusted-users = [ "root" "${user}" ]; };
              };
            };
            # nix-darwin specific configuration
            darwin = { pkgs, ... }: {
              imports = [
                (import ./darwin)
              ];
              users.users.${user} = {
                # MacOS User
                home = "/Users/${user}";
                shell = pkgs.fish; # Default Shell
              };
              programs.fish.enable = true;
              networking.hostName = "${hostname}";
              networking.computerName = "${hostname}";
              networking.localHostName = "${hostname}";
              system.stateVersion = darwinStateVersion;
              nix = {
                settings = { trusted-users = [ "root" "${user}" ]; };
              };
            };
          };

          # All home-manager configurations are kept here.
          homeModules = {
            # Common home-manager configuration shared between Linux and macOS.
            common = import ./home-manager { inherit user; };
            # home-manager config specific to NixOS
            linux = import ./home-manager/linux { inherit user; };
            # home-manager config specifi to Darwin
            darwin = import ./home-manager/darwin { inherit user; };
          };
        };
    };
}

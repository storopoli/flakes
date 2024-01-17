{
  description = "NixOS/MacOS Minimalist-Hardened-Privacy-oriented Configs";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-root.url = "github:srid/flake-root";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    nixos-flake.url = "github:srid/nixos-flake";
    rust-overlay.url = "github:oxalica/rust-overlay";
    agenix.url = "github:ryantm/agenix";
    impermanence.url = "github:nix-community/impermanence";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.3.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    arkenfox = {
      url = "github:dwarfmaster/arkenfox-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovix = {
      url = "github:storopoli/neovix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/release-23.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  outputs = inputs @ { self, ... }:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      imports = [
        inputs.nixos-flake.flakeModule
        inputs.flake-root.flakeModule
        inputs.treefmt-nix.flakeModule
      ];

      perSystem =
        { config
        , inputs'
        , pkgs
        , system
        , ...
        }:
        let
          pkgs = import inputs.nixpkgs { inherit system; };
        in
        {
          devShells = {
            # run by `nix develop` or `nix-shell`(legacy)
            default = import ./shell.nix { inherit pkgs; };
            tools = _:
              {
                treefmt = config.treefmt.build.wrapper;
              }
              // config.treefmt.build.programs;
          };

          # treefmt config
          treefmt.config = {
            inherit (config.flake-root) projectRootFile;
            package = pkgs.treefmt;

            # Enable the formatters
            programs.beautysh.enable = true;
            programs.nixpkgs-fmt.enable = true;
            programs.prettier.enable = true;
            programs.stylua.enable = true;
            programs.taplo.enable = true;
          };
        };

      flake =
        let
          stateVersion = "23.11";
          darwinStateVersion = 4;
          homeStateVersion = "23.11";
          androidStateVersion = "23.05";
        in
        {
          # Configurations for Linux (NixOS) machines
          nixosConfigurations = {
            framework = self.nixos-flake.lib.mkLinuxSystem {
              nixpkgs.hostPlatform = "x86_64-linux";
              imports = [
                self.nixosModules.common
                self.nixosModules.linux
                # Secure Boot
                inputs.lanzaboote.nixosModules.lanzaboote
                # Framework nixos-hardware
                inputs.nixos-hardware.nixosModules.framework-13-7040-amd
                # Your home-manager configuration
                self.nixosModules.home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    users.user = {
                      imports = [
                        self.homeModules.common
                        self.homeModules.linux
                        inputs.nur.hmModules.nur
                        inputs.arkenfox.hmModules.default
                      ];
                      home.stateVersion = "${stateVersion}";
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
                  home-manager.users.user = {
                    imports = [ self.homeModules.common self.homeModules.darwin ];
                    home.stateVersion = homeStateVersion;
                  };
                }
              ];
            };
            macbook_x86 = self.nixos-flake.lib.mkMacosSystem {
              nixpkgs.hostPlatform = "x86_64-darwin";
              imports = [
                self.nixosModules.common
                self.nixosModules.darwin
                # Your home-manager configuration
                self.darwinModules_.home-manager
                {
                  home-manager.users.user = {
                    imports = [ self.homeModules.common self.homeModules.darwin ];
                    home.stateVersion = homeStateVersion;
                  };
                }
              ];
            };
          };

          # Configuration for Android
          nixOnDroidConfigurations = {
            pixel = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
              modules = [
                {
                  system.stateVersion = androidStateVersion;
                }
                ./android
                {
                  home-manager = {
                    useGlobalPackages = true;
                    useUserPackages = true;
                    backupFileExtension = "hm-bak";
                    config = {
                      imports = [
                        ./home-manager/android
                      ];
                      home.stateVersion = androidStateVersion;
                    };
                  };
                }
              ];
            };
          };

          # All nixos/nix-darwin configurations are kept here.
          nixosModules = {
            # Common nixos/nix-darwin configuration shared between Linux and macOS.
            common = {
              imports = [
                # Custom inputs
                inputs.agenix.nixosModules.default
                {
                  nixpkgs.overlays = [
                    inputs.rust-overlay.overlays.default
                    inputs.agenix.overlays.default
                    inputs.neovix.overlays.default
                  ];
                }
                (import ./common)
              ];
            };
            # NixOS specific configuration
            linux = {
              imports = [
                # Custom inputs
                inputs.nur.nixosModules.nur
                inputs.impermanence.nixosModules.impermanence
                inputs.disko.nixosModules.disko
                { nixpkgs.overlays = [ inputs.nur.overlay ]; }
                (import ./linux)
              ];
              system.stateVersion = "${stateVersion}";
            };
            # nix-darwin specific configuration
            darwin = {
              imports = [ (import ./darwin) ];
              system.stateVersion = darwinStateVersion;
            };
          };

          # All home-manager configurations are kept here.
          homeModules = {
            # Common home-manager configuration shared between Linux and macOS.
            common = import ./home-manager;
            # home-manager config specific to NixOS
            linux = import ./home-manager/linux;
            # home-manager config specifi to Darwin
            darwin = import ./home-manager/darwin;
          };
        };
    };
}

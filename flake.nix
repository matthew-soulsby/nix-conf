{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home manager
    home-manager = {
        url = "github:nix-community/home-manager/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin = {
        url = "github:catppuccin/nix";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    catppuccin,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      mattsoulsby = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
          vars = {
            wallpaper = ./assets/wallpapers/catppuccin/mocha/orb-catppuccin-mocha.png;
          };
        };
        # > Our main nixos configuration file <
        modules = [
          catppuccin.nixosModules.catppuccin
          ./nixos/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = let 
        pkg-src = nixpkgs.legacyPackages.x86_64-linux; 
    in {
      "mattsoulsby@nix-laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = pkg-src; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          vars = {
            wallpaper = ./assets/wallpapers/catppuccin/mocha/orb-catppuccin-mocha.png;
            portrait = ./assets/portraits/ai-small-body.jpg;
            fonts = {
                serif = {
                    name = "Ubuntu Nerd Font";
                    package = pkg-src.nerd-fonts.ubuntu;
                };
                sans-serif = {
                    name = "UbuntuSans Nerd Font";
                    package = pkg-src.nerd-fonts.ubuntu-sans;
                };
                mono = {
                    name = "JetBrainsMono Nerd Font";
                    package = pkg-src.nerd-fonts.jetbrains-mono;
                };
            };
          };
        };
        # > Our main home-manager configuration file <
        modules = [
          catppuccin.homeModules.catppuccin
          ./home-manager/home.nix
        ];
      };
    };
  };
}

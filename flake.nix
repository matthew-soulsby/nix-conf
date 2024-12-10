{
  description = "Your new nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";
    
    # Walker App Launcher
    walker.url = "github:abenz1267/walker";
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
    homeConfigurations = {
      "mattsoulsby@nix-laptop" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          vars = {
            wallpaper = ./assets/wallpapers/catppuccin/mocha/orb-catppuccin-mocha.png;
            portrait = ./assets/portraits/catppuccin.png;
          };
        };
        # > Our main home-manager configuration file <
        modules = [
          catppuccin.homeManagerModules.catppuccin
          ./home-manager/home.nix
        ];
      };
    };
  };
}

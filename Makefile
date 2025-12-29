system:
	sudo nixos-rebuild switch --flake ".#mattsoulsby"

home:
	home-manager switch --flake ".#mattsoulsby@nix-laptop" -b backup

update:
	# Update flake sources
	nix flake update
	# Ensure that font cache is properly cleared
	fc-cache -rf

news:
	home-manager news --flake ".#mattsoulsby@nix-laptop"

cleanup:
	sudo nix-collect-garbage --delete-old
	nix-collect-garbage --delete-old

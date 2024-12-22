system:
	sudo nixos-rebuild switch --flake ".#mattsoulsby"

home:
	home-manager switch --flake ".#mattsoulsby@nix-laptop"

news:
	home-manager news --flake ".#mattsoulsby@nix-laptop"

cleanup:
	nix-collect-garbage --delete-old

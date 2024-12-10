system:
	sudo nixos-rebuild switch --flake ".#mattsoulsby"

home:
	home-manager switch --flake ".#mattsoulsby@nix-laptop"

cleanup:
	echo TODO

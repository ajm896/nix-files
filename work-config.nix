{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
	environment.systemPackages = with pkgs;
		[ 
			pkgs.ripgrep
			pkgs.alacritty
			pkgs.zsh-completions
			pkgs.fzf
			pkgs.zoxide
			pkgs._1password
		];
	nixpkgs.config.allowUnfree = true;
  
	system.defaults = {
		dock.autohide = false;
		menuExtraClock.Show24Hour = true;
		dock.orientation = "right";
		dock.magnification = true;
		finder.FXPreferredViewStyle = "clmv";
	};
  
  # Auto upgrade nix package and the daemon service.
	services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;
  
  # Necessary for using flakes on this system.
	nix.settings.experimental-features = "nix-command flakes";
  
  # Create /etc/zshrc that loads the nix-darwin environment.
	programs.zsh.enable = true;
  
  # Set Git commit hash for darwin-version.
	system.configurationRevision = self.rev or self.dirtyRev or null;
  
  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
	system.stateVersion = 5;
	system.keyboard.enableKeyMapping = true;
	#system.keyboard.remapCapsLockToControl = true;
  
  # The platform the configuration will be used on.
	nixpkgs.hostPlatform = "aarch64-darwin";
  
  
}

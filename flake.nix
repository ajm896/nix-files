{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    
    #nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nix-darwin, home-manager, ... } @ inputs:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake ./nix-files
      darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs self;};
        modules = [ 
         ./hosts/macos/work/config.nix
	        home-manager.darwinModules.home-manager {
		        home-manager.useGlobalPkgs = true;
		        home-manager.useUserPackages = true;
		        home-manager.users.amorris = import ./home.nix;
	        }
        ];
      };

      darwinConfigurations."home" = nix-darwin.lib.darwinSystem {
        specialArgs = {inherit inputs self;};
        modules = [ 
         ./hosts/macos/home/config.nix
	        home-manager.darwinModules.home-manager {
		        home-manager.useGlobalPkgs = true;
		        home-manager.useUserPackages = true;
		        home-manager.users.amorris = import ./home.nix;
	        }
        ];
      };
      
      # Expose the package set, including overlays, for convenience.
      # darwinPackages = self.darwinConfigurations."work".pkgs;
    };
}
  

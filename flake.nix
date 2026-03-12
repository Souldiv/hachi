{
  description = "hachi — declarative macOS system configuration";

  inputs =  {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }: 
  {
    darwinConfigurations.hachi = nix-darwin.lib.darwinSystem { modules = [
      ./configuration.nix
      home-manager.darwinModules.home-manager
    ];};

  };
}

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

    devShells.aarch64-darwin.default =
      let pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      in pkgs.mkShell { packages = [ pkgs.nixfmt pkgs.nil ]; };
  };
}

{ config, pkgs, ... }: {
  environment = {
    shells = [ pkgs.nushell ];
    variables = {
        EDITOR = "vim";
    };
  };
  
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  homebrew = {
    enable = true;
    taps = [
      "loft-sh/tap"
    ];
    brews = [
      "loft-sh/tap/vcluster"
    ];
  };

  home-manager.users.amrutphadke = import ./home.nix;

  nix.enable = false;
  nixpkgs.hostPlatform = "aarch64-darwin";

  power = {
    restartAfterFreeze = true;
  };

  system = {
    primaryUser = "amrutphadke";
    startup.chime = false;
    stateVersion = 6;
  };

  users.users.amrutphadke = {
    home = "/Users/amrutphadke";
    shell = pkgs.nushell;
  };
}

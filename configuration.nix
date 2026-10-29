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
      "chipmk/tap"
      "fujiwara/tap"
      "hashicorp/tap"
      "messense/macos-cross-toolchains"
      "microsoft/mssql-release"
      "siderolabs/tap"
      "tilt-dev/tap"
    ];
    brews = [
      "loft-sh/tap/vcluster"
      "herdr"
      "mysql"
      "ansible"
      "awscli"
      "bash"
      "cloudflared"
      "docker-compose"
      "gh"
      "git-lfs"
      "gnu-tar"
      "gnupg"
      "helm"
      "helmfile"
      "imagemagick"
      "iproute2mac"
      "kcat"
      "krew"
      "kubectl-radar"
      "node"
      "pkgconf"
      "poetry"
      "poppler"
      "powershell"
      "prometheus"
      "python@3.12"
      "python@3.13"
      "render"
      "telnet"
      "tfenv"
      "tilt"
      "chipmk/tap/docker-mac-net-connect"
      "fujiwara/tap/tfstate-lookup"
      "hashicorp/tap/packer"
      "messense/macos-cross-toolchains/x86_64-unknown-linux-gnu"
      "microsoft/mssql-release/msodbcsql18"
      "siderolabs/tap/talosctl"
      "tilt-dev/tap/ctlptl"
    ];
    casks = [
      "session-manager-plugin"
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

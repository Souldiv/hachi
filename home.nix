{ config, pkgs, ... }: {
  imports = [ ./zellij.nix ];
  nixpkgs.config.allowUnfree = true;
  home = {
    file = {
      "Library/Application Support/com.mitchellh.ghostty/config" = {
        force = true;
        text = ''
          theme = Monokai Soda
          maximize = true
          font-size = 22
          command = /run/current-system/sw/bin/nu --login --commands "zellij"
          font-family = JetBrains Mono Nerd Font
          macos-option-as-alt = left
          keybind = alt+left=unbind
          keybind = alt+right=unbind
        '';
      };
    };
    homeDirectory = "/Users/amrutphadke";
    packages = with pkgs; [
      ghostty-bin
      docker-client
      kubectl
    ];
    stateVersion = "25.05";
    shell.enableNushellIntegration = true;
    username = "amrutphadke";
  };

  programs = {
    vscode = {
      enable = true;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          anthropic.claude-code
          jnoortheen.nix-ide
          hashicorp.terraform
          yzhang.markdown-all-in-one
        ];
        userSettings = {
          "window.titleBarStyle" = "native";
        };
      };
    };
    nushell = {
      enable = true;
      envFile.text = ''
        $env.PATH = ($env.PATH | split row (char esep) | prepend "/opt/homebrew/bin" | prepend "/opt/homebrew/sbin" | prepend "/usr/local/bin" | prepend "/run/current-system/sw/bin" | prepend "/Users/amrutphadke/.nix-profile/bin" | prepend "/nix/var/nix/profiles/default/bin")
      '';
      environmentVariables = {
        EDITOR = "vim";
      };
      shellAliases = {
        ll = "ls -l";
        la = "ls -al";
      };
    };
    kubecolor.enable = true;
    k9s = {
      enable = true;
    };
    starship = {
      enable = true;
      presets = [
        "nerd-font-symbols"
        "bracketed-segments"
      ];
      settings = {
        aws.disabled = true;
        gcloud.disabled = true;
        directory = {
          truncation_length = 3;
          truncate_to_repo = true;
        };
        git_branch = {
          format = "[$symbol$branch(:$remote_branch)]($style) ";
        };
        git_status = {
          format = "([$all_status$ahead_behind]($style) )";
          conflicted = "=";
          ahead = "⇡\${count}";
          behind = "⇣\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          untracked = "?\${count}";
          stashed = "*\${count}";
          modified = "!\${count}";
          staged = "+\${count}";
          deleted = "✘\${count}";
        };
        kubernetes = {
          disabled = false;
          style = "#d0d013 bold";
          format = "[$symbol$context(/$namespace)]($style) ";
          contexts = [
            {
              context_pattern = "arn:aws:eks:.*:.*:cluster/(?P<cluster>[\\w-]+)";
              context_alias = "$cluster";
            }
          ];
        };
        docker_context = {
          disabled = false;
          format = "[$symbol$context]($style) ";
        };
        nix_shell = {
          disabled = false;
          format = "[$symbol$state($name)]($style) ";
        };
        cmd_duration = {
          min_time = 2000;
          format = "[$duration]($style) ";
        };
      };
      enableNushellIntegration = true;
    };
  };
}

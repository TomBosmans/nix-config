{ self, config, ... }: {
  flake.nixosModules.zsh = {
    imports = [config.flake.wrappers.myZsh.install];

    wrappers.myZsh = {
      enable = true;
      asSystemDefault = true;
    };
  };

  flake.wrappers.myZsh = { pkgs, lib, wlib, ... }: let
    myPackages = self.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    imports = [wlib.wrapperModules.zsh];

    hmSessionVariables = null;
    skipGlobalRC = true;

    runtimePkgs = [
      pkgs.zoxide
      myPackages.myBat
      myPackages.myEza
      myPackages.myFzf
      myPackages.myStarship
    ];

    env = {
      MANPAGER = "${lib.getExe myPackages.myNvim} +Man!"; # use nvim as man pager
    };

    zshAliases = {
      cd = "z";
      ls = "eza --icons --classify";
      cat = "bat --plain";
    };

    zshrc.content = ''
      bindkey -e

      HISTFILE=~/.histfile
      HISTSIZE=1000000
      SAVEHIST=1000000

      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_SAVE_NO_DUPS
      setopt HIST_REDUCE_BLANKS
      setopt INC_APPEND_HISTORY_TIME
      setopt EXTENDED_HISTORY
      setopt SHARE_HISTORY

      autoload -Uz compinit
      mkdir -p "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
      compinit -d "''${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"

      source <(fzf --zsh)
      zstyle ':fzf-tab:*' use-fzf-default-opts yes

      source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      eval "$(zoxide init zsh)"
      eval "$(starship init zsh)"
    '';
  };
}

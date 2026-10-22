{ self, inputs, config, ... }: {
  flake.nixosModules.yazi = {
    imports = [
      self.nixosModules.trash
      config.flake.wrappers.myYazi.install
      ({ config, pkgs, lib, ... }: let
        myYazi = config.wrappers.myYazi.wrapper;
        yaziDesktop = pkgs.makeDesktopItem {
          name = "yazi";
          desktopName = "Yazi";
          comment = "Browse files with Yazi";
          exec = "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty} --detach ${lib.getExe myYazi} %f";
          mimeTypes = ["inode/directory"];
          terminal = false;
          categories = ["System" "FileTools" "FileManager"];
        };
      in {
        environment.systemPackages = [yaziDesktop];

        xdg.mime.defaultApplications."inode/directory" = "yazi.desktop";
      })
    ];

    wrappers.myYazi.enable = true;
  };

  flake.wrappers.myYazi = { pkgs, lib, wlib, ... }: let
    system = pkgs.stdenv.hostPlatform.system;
    myPackages = self.packages.${pkgs.stdenv.hostPlatform.system};
    kitty = lib.getExe myPackages.myKitty;
    nvim = lib.getExe myPackages.myNvim;
    opencode = lib.getExe myPackages.myOpencode;
    direnv = lib.getExe inputs.nixpkgs.legacyPackages.${system}.direnv;
    zip = lib.getExe pkgs.zip;
    theme = lib.recursiveUpdate
      (builtins.fromTOML (builtins.readFile "${inputs.catppuccin-yazi}/themes/macchiato/catppuccin-macchiato-blue.toml"))
      {mgr.syntect_theme = myPackages.myBat.theme;};
  in {
    imports = [wlib.wrapperModules.yazi];
    package = pkgs.yazi.override {fzf = myPackages.myFzf;};

    runtimePkgs =
      [inputs.nixpkgs.legacyPackages.${system}.direnv]
      ++ lib.optionals pkgs.stdenv.isLinux [
        pkgs.wl-clipboard
        pkgs.xdg-utils
      ];

    settings = {
      inherit theme;

      yazi.opener.edit = [{
        run = ''${direnv} exec "$PWD" ${nvim} "$@"'';
        block = true;
        for = "unix";
      }];

      keymap.mgr.prepend_keymap = [
        {
          on = ["e" "t"];
          run = "shell '${kitty} --detach --directory=\"$PWD\"'";
          desc = "Open terminal here";
        }
        {
          on = ["e" "o"];
          run = "shell '${kitty} --detach --directory=\"$PWD\" ${opencode}'";
          desc = "Open opencode";
        }
        {
          on = ["e" "z"];
          run = "shell 'if [ -z \"%s\" ]; then echo \"No files selected\"; sleep 1; else ${zip} -jr \"$(basename \"$PWD\").zip\" %s; fi'";
          desc = "Zip selected files";
        }
      ];
    };
  };
}

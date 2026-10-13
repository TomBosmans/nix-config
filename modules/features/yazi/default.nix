{ self, inputs, ... }: {
  flake.nixosModules.yazi = { pkgs, lib, ... }: let
    myYazi = self.packages.${pkgs.stdenv.hostPlatform.system}.myYazi;
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
    environment.systemPackages = [
      myYazi
      yaziDesktop
    ];

    xdg.mime.defaultApplications."inode/directory" = "yazi.desktop";
  };

  perSystem = { pkgs, lib, self', ... }: let
    kitty = lib.getExe self'.packages.myKitty;
    opencode = lib.getExe self'.packages.myOpencode;
    zip = lib.getExe pkgs.zip;
    theme = lib.recursiveUpdate
      (builtins.fromTOML (builtins.readFile "${inputs.catppuccin-yazi}/themes/macchiato/catppuccin-macchiato-blue.toml"))
      {mgr.syntect_theme = self'.packages.myBat.theme;};
  in {
    packages.myYazi = inputs.wrapper-modules.wrappers.yazi.wrap {
      inherit pkgs;
      package = pkgs.yazi.override {fzf = self'.packages.myFzf;};

      runtimePkgs = lib.optionals pkgs.stdenv.isLinux [
        pkgs.wl-clipboard
        pkgs.xdg-utils
      ];

      settings = {
        inherit theme;

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
  };
}

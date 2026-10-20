{ self, inputs, config, ... }: {
  flake.nixosModules.opencode = {
    imports = [
      config.flake.wrappers.myOpencode.install
      ({ config, pkgs, lib, ... }: let
        myOpencode = config.wrappers.myOpencode.wrapper;
        opencodePackage = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode;
        opencodeDesktop = pkgs.makeDesktopItem {
          name = "opencode";
          desktopName = "OpenCode";
          comment = "AI coding agent";
          exec = "${lib.getExe self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty} --detach ${lib.getExe myOpencode}";
          icon = "${opencodePackage.src}/packages/desktop/icons/prod/icon.png";
          terminal = false;
          categories = ["Development"];
        };
      in {
        environment.systemPackages = [opencodeDesktop];
      })
    ];

    wrappers.myOpencode.enable = true;
  };

  flake.wrappers.myOpencode = { pkgs, wlib, ... }: {
    imports = [wlib.wrapperModules.opencode];
    package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.opencode;

    settings = {
      "$schema" = "https://opencode.ai/config.json";
      autoupdate = false;
      formatter = true;
      lsp = true;
      instructions = [./AGENTS.md];
      skills.paths = [./skills];

      mcp = {
        atlassian = {
          enabled = false;
          type = "remote";
          url = "https://mcp.atlassian.com/v1/mcp";
        };
        chrome-devtools = {
          command = [
            "chrome-devtools-mcp"
            "--no-usage-statistics"
          ];
          enabled = false;
          type = "local";
        };
        github = {
          command = [
            "sh"
            "-c"
            "GITHUB_PERSONAL_ACCESS_TOKEN=$(gh auth token) github-mcp-server stdio"
          ];
          enabled = false;
          type = "local";
        };
        gitlab = {
          command = [
            "glab"
            "mcp"
            "serve"
          ];
          enabled = false;
          type = "local";
        };
        mermaid = {
          enabled = false;
          type = "remote";
          url = "https://mcp.mermaid.ai/mcp";
        };
      };

      permission.read = {
        "*" = "allow";
        "*.env" = "deny";
        "*.env.*" = "deny";
        "*.env.example" = "allow";
      };
    };

    tui-settings = {
      "$schema" = "https://opencode.ai/tui.json";
      theme = "catppuccin-macchiato";
    };
  };
}

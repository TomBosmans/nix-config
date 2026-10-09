{ self, inputs, ... }: {
  flake.nixosModules.opencode = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.myOpencode
    ];
  };

  perSystem = { system, ... }: let
    pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
  in {
    packages.myOpencode = inputs.wrapper-modules.wrappers.opencode.wrap {
      inherit pkgs;

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
        theme = "matugen";
      };
    };
  };
}

{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

    wrapper-modules.url = "github:nix-community/nix-wrapper-modules";

    noctalia = { url = "github:noctalia-dev/noctalia"; inputs.nixpkgs.follows = "nixpkgs"; };
    noctalia-greeter = { url = "github:noctalia-dev/noctalia-greeter"; inputs.nixpkgs.follows = "nixpkgs"; };

    catppuccin-bat = { url = "github:catppuccin/bat"; flake = false; };
    catppuccin-eza = { url = "github:catppuccin/eza"; flake = false; };
    catppuccin-fzf = { url = "github:catppuccin/fzf"; flake = false; };
    catppuccin-yazi = { url = "github:catppuccin/yazi"; flake = false; };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake
    {inherit inputs;}
    (inputs.import-tree ./modules);
}

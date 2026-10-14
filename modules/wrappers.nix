# Import the nix-wrapper-modules flake-parts module. It adds flake.wrappers
# and generates per-system packages and install modules from its definitions.
# Docs: https://nix-community.github.io/nix-wrapper-modules/md/getting-started.html#flake-parts
{ inputs, ... }: {
  imports = [inputs.wrapper-modules.flakeModules.wrappers];
}

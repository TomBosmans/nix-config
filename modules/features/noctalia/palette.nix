{ config, inputs, lib, ... }: let
  name = config.noctalia.palette;
  file = "${inputs.noctalia-palettes}/${name}/${name}.json";
  source = builtins.fromJSON (builtins.readFile file);
in {
  options.noctalia.palette = lib.mkOption {
    type = lib.types.str;
    default = "Catppuccin Macchiato Blue";
    description = "Noctalia palette used by the shell and greeter.";
  };

  config._module.args.noctaliaPalette = {
    inherit name file;
    inherit (source) dark light;
  };
}

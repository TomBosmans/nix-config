{
  flake.wrappers.myStarship = { wlib, ... }: {
    imports = [wlib.wrapperModules.starship];

    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = "$directory$git_branch$git_status$line_break$character";

      directory = {
        format = "[$path]($style)";
        style = "bold blue";
        truncate_to_repo = false;
        truncation_length = 0;
      };

      git_branch = {
        format = " [$branch]($style)";
        style = "bold green";
      };

      git_status = {
        format = "([ $all_status$ahead_behind]($style))";
        style = "bold red";
      };

      character = {
        success_symbol = "[▶](bold)";
        error_symbol = "[▶](bold)";
      };
    };
  };
}

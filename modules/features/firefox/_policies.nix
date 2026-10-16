{
  DisableAppUpdate = true;

  ExtensionSettings = {
    "uBlock0@raymondhill.net" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    };

    "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
    };

    "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
    };

    "{d49033ac-8969-488c-afb0-5cdb73957f41}" = {
      installation_mode = "force_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/catppuccin-macchiato-blue/latest.xpi";
    };
  };

  SearchEngines = {
    Add = [{
      Name = "DuckDuckGo (Nix)";
      URLTemplate = "https://duckduckgo.com/?q={searchTerms}";
      SuggestURLTemplate = "https://duckduckgo.com/ac/?q={searchTerms}&type=list";
      Method = "GET";
      Alias = "ddg";
      Description = "DuckDuckGo Search";
    }];
    Default = "DuckDuckGo (Nix)";
    DefaultPrivate = "DuckDuckGo (Nix)";
  };
}

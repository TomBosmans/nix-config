{
  keymap = [
    {
      name = "Kitty clipboard";
      application.only = ["kitty"];
      exact_match = true;
      remap = {
        "Super-C" = "Ctrl-Shift-C";
        "Super-V" = "Ctrl-Shift-V";
      };
    }
    {
      name = "Clipboard";
      application.not = ["kitty"];
      exact_match = true;
      remap = {
        "Super-C" = "Ctrl-C";
        "Super-V" = "Ctrl-V";
      };
    }
  ];
}

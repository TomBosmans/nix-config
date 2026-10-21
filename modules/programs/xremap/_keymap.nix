{
  keymap = [
    {
      name = "Firefox Emacs editing";
      application.only = ["firefox"];
      exact_match = true;
      remap = {
        "Ctrl-A" = "Home";
        "Ctrl-E" = "End";
        "Ctrl-B" = "Left";
        "Ctrl-F" = "Right";
        "Ctrl-P" = "Up";
        "Ctrl-N" = "Down";
        "Ctrl-D" = "Delete";
        "Ctrl-H" = "Backspace";
        "Ctrl-K" = ["Shift-End" "Delete"];
        "Ctrl-U" = ["Shift-Home" "Backspace"];
        "Alt-B" = "Ctrl-Left";
        "Alt-F" = "Ctrl-Right";
        "Super-Enter" = "Ctrl-N";
        "Super-P" = "Ctrl-P";
      };
    }
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

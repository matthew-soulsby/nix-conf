{...}:

{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };

    keybindings = {
      "ctrl+c" = "copy_or_interrupt";
      "ctrl+v" = "paste_from_clipboard";
    };

    settings = {
      # Disable close confirmation
      confirm_os_window_close = 0;

      # Smooth cursor
      cursor_trail = "3";
      cursor_trail_decay = "0.1 0.4";
    };
  };
}

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
    };
  };
}

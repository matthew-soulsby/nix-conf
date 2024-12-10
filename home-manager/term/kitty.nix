{...}:

{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      # Disable close confirmation
      confirm_os_window_close = 0;
    };
  };
}

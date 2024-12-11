{pkgs, ...}:

{
  programs.tmux = {
    enable = true;
    catppuccin.extraConfig = ''
      set -g @catppuccin_status_background "#{@thm_bg}"
      set -g @catppuccin_window_default_text " #W  "
      set -g @catppuccin_window_current_text " #W  "
      set -g @catppuccin_window_status "none"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_status_style "rounded"
    '';

    baseIndex = 1;
    prefix = "C-s";
    keyMode = "vi";
    disableConfirmationPrompt = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
    ];

    extraConfig = ''
      set-option -sg escape-time 10
      set-option -sg default-terminal "screen-256color"
      set-option -sa terminal-overrides ",xterm*:Tc"

      set-option -g focus-events on
      set-option -g destroy-unattached
      set -g status-style bg=default
      set -g status-left-length 90
      set -g status-right-length 90
      set -g status-left ""
      set -g status-right ""
      set -g status-justify absolute-centre
    '';
  };
}

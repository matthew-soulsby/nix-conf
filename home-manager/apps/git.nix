{...}:

{
  programs.git = {
    enable = true;
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "matthew-soulsby";
        email = "83053424+matthew-soulsby@users.noreply.github.com";
      };
      core = {
        editor = "vim";
      };
    };
  };
}

{...}:

{
  programs.git = {
    enable = true;
    settings = {
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

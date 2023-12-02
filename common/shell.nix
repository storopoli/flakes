{ pkgs, ... }:

{
  environment = {
    shells = with pkgs; [ fish ]; # Default Shell

    # Environment Variables
    variables = {
      EDITOR = "vim";
      VISUAL = "vim";
      LANG = "en_US.UTF-8";
    };
  };
}

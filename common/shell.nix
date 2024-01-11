{ pkgs, ... }:

{
  environment = {
    shells = with pkgs; [ fish ]; # Default Shell

    # Environment Variables
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
      LANG = "en_US.UTF-8";
    };
  };
}

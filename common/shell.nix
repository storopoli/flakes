{ pkgs, ... }:

{
  environment = {
    shells = with pkgs; [ fish helix ]; # Default Shell

    # Environment Variables
    variables = {
      EDITOR = "hx";
      VISUAL = "hx";
      LANG = "en_US.UTF-8";
    };
  };
}


{ config, pkgs, ... }:

let
  myDotfiles = [ "nvim" "xmonad" "xmobar" "picom" "alacritty" ];
in
{
  home.username = "eric";
  home.homeDirectory = "/home/eric";

  home.file = builtins.listToAttrs (map (name: {
    name =".config/${name}";
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixos/dotfiles/${name}";
    };
  }) myDotfiles);
  
  home.stateVersion = "26.11";
  programs.home-manager.enable = true;
  services.betterlockscreen.enable = true;
}

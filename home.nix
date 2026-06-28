
{ config, pkgs, ... }:

let
  myDotfiles = [ "nvim" "xmonad" "xmobar" "picom" "alacritty" ];
in
{
  home.username = "eric";
  home.homeDirectory = "/home/eric";
  home.stateVersion = "26.11";
  home.file = {
    ".icons/default".source = "${pkgs.vanilla-dmz}/share/icons/Vanilla-DMZ"; 
  } // builtins.listToAttrs (map (name: {
    name =".config/${name}";
    value = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nixos/dotfiles/${name}";
    };
  }) myDotfiles);
  
  programs.home-manager.enable = true;
  programs.rbw = {
    enable = true;
    settings = {
      email = "eric.corriveau@proton.me";
      lock_timeout = 300;
      pinentry = pkgs.pinentry-gnome3;
      base_url = "https://vaultwarden.63moissons.com";
    };
  };

  services.betterlockscreen.enable = true;
}

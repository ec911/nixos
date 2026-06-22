
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "p53";
  networking.networkmanager = { 
    enable = true;
    wifi.backend = "iwd";
  };

  time.timeZone = "America/Toronto";
  
  services = {
    xserver = {
      enable = true;
      autoRepeatDelay = 300;
      autoRepeatInterval = 35;
      xkb = {
	      layout = "us,ca";
	      options = "grp:alt_shift_toggle"; 
      };
      displayManager.startx = {
	enable = true;
	generateScript = true;
	extraCommands = ''
	  picom -b
	  feh --bg-fill ~/.config/wallpapers/nature.jpg
	  xsetroot -cursor_name left_ptr
	'';
      };
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
    printing = {
      enable = true;
      drivers = [ pkgs.brlaser ];
    };
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    tailscale.enable = true;
    tlp = {
      enable = true;
    };
  };

  users.users.eric = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "kvm" "adbusers" ];
  };

  programs.firefox.enable = true;
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    flags = [ "--cmd cd" ];
  };

  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    dmenu
    feh
    fzf
    git
    neovim
    nnn
    pamixer
    picom
    ripgrep
    tree
    unzip
    wget
    xclip
    xmobar
    zathura
  ];
  
  fonts.packages = with pkgs;[
    nerd-fonts.jetbrains-mono
  ];

  security.pam.services.i3lock.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

  system.stateVersion = "25.11"; # Did you read the comment?

}


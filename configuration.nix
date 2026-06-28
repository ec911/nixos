
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.helium-flake.nixosModules.default
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
	      options = "grp:shifts_toggle";
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
    openssh.enable = true;
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
  # Enable the Virtual File System backend needed for MTP/microSD detection
    gvfs.enable = true;
  };

  users.users.eric = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "kvm" "adbusers" ];
  };
  
  programs.bash = {
    enable = true;
    loginShellInit = ''
      if [[ -z "$DISPLAY" && "$(tty)" == "/dev/tty1" ]]; then
        exec startx
      fi
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.helium = {
    enable = true;
    # 🚩 Flags - Command-line arguments always passed to Helium
    flags = [
      "--disable-gpu"
      "--ozone-platform-hint=auto"
    ];
    # 🎯 Policies - Written to /etc/chromium/policies/managed/helium-nixos.json
    # Also written to /etc/helium/policies/managed/ for future compatibility
    policies = {
      "BrowserSignin" = 0;
      "PasswordManagerEnabled" = false;
      "SyncDisabled" = true;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [ "en-US" ];
    };
  };
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    flags = [ "--cmd cd" ];
  };

  environment.systemPackages = with pkgs; [
    alacritty
    brightnessctl
    clang
    cmake
    coreutils
    dmenu
    feh
    fd
    fzf
    gcc
    git
    haskell-language-server
    libtool
    lua-language-server
    neovim
    nil # Nix lsp
    nnn
    p7zip
    pamixer
    picom
    qutebrowser
    ripgrep
    tree
    thunar
    thunar-volman
    unzip
    wget
    xclip
    xmobar
    zathura
  ];
  
  fonts.packages = with pkgs;[
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
  ];

  security.pam.services.i3lock.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11"; # Did you read the comment?

}


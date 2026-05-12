{ config, pkgs, ... }: {
  home.username = "bartek";
  home.homeDirectory = "/home/bartek";

  home.packages = with pkgs; [
    kitty
    samba
    fastfetch
    cava
    cbonsai
    cmatrix
    firefox
    jellyfin-desktop
    bat
    makemkv
    handbrake
    OVMF
    qemu
    localsend
  ];

  # Cursors
  home.file.".local/share/icons" = {
    source = ./resources/icons;
    recursive = true;
  };

  # kitty
  home.file.".config/kitty" = {
    source = ./resources/kitty;
    recursive = true;
  };

  # Starship (PLEASE make better docs)
  programs.starship.enable = true;
  home.file.".config/starship.toml" = {
    source = ./resources/starship.toml;
  };

  # SwayWM
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      terminal = "kitty";
      startup = [
        {command = "waybar";}
	{command = "swaybg -o eDP-1 -i /etc/nixos/resources/swaybg.png -m fill";}
      ];
      bars = [];
    };
  };

  home.stateVersion = "24.11";
}

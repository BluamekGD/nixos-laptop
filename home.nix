{ config, pkgs, hyprland, ... }: {
  home.username = "bartek";
  home.homeDirectory = "/home/bartek";

  wayland.windowManager.hyprland = {
    enable = true;
    package = hyprland.packages.x86_64-linux.hyprland;
    settings = {
      "$mod" = "SUPER";
      bind = [
        "$mod, Return, exec, kitty"
        "$mod, Q, killactive"
        "$mod, D, exec, fuzzel"
        "$mod, F, fullscreen"
      ];
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
      };
    };
  };

  home.packages = with pkgs; [
    kitty
    fuzzel
    waybar
    swaylock
    wl-clipboard
    brightnessctl
    playerctl
    fastfetch
    neovim
  ];

  home.stateVersion = "24.11";
}

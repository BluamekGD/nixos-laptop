{ config, pkgs, ... }: {
  home.username = "bartek";
  home.homeDirectory = "/home/bartek";

  home.packages = with pkgs; [
    kitty
    samba
    firefox
    jellyfin-desktop
    bat
    makemkv
    handbrake
    localsend
  ];

  # Cursor
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 20;
    gtk.enable = true;
    x11.enable = true;
  };

  # Terminal
  home.file.".config/kitty" = {
    source = ./resources/kitty;
    recursive = true;
  };
  programs.starship.enable = true;
  home.file.".config/starship.toml" = {
    source = ./resources/starship.toml;
  };
  home.file.".zshrc" = {
    source = ./resources/.zshrc;
  };

  # Fuzzel
  home.file.".config/fuzzel/fuzzel.ini" = {
    source = ./resources/fuzzel.ini;
  };

  # SwayWM
  wayland.windowManager.sway = {
    enable = true;
    xwayland = true;
    config = rec {
      gaps = {
        inner = 4;
	outer = 10;
      };
      window = {
        border = 6;
	titlebar = false;
      };

      floating = {
        border = 6;
	titlebar = false;
      };

      colors = {
        focused = {
          border = "#ebdbb2";
	};
	unfocused = {
          border = "#282828";
	};
      };
      seat = {
        "*" = {
          xcursor_theme = "${config.home.pointerCursor.name} ${toString config.home.pointerCursor.size}";
        };
      };
      modifier = "Mod4";
      terminal = "kitty --title kitty";
      menu = "fuzzel";
      defaultWorkspace = "1";
      startup = [
        {command = "waybar";}
	{command = "swaybg -o eDP-1 -i /etc/nixos/resources/swaybg.png -m fill";}
	# The best solution to a problem is usually the easiest. -Ellen McLain (GLaDOS), 2011
	{command = "swaymsg workspace number 1";}
      ];
      bars = [];
      keybindings = let
        mod = config.wayland.windowManager.sway.config.modifier;
	terminal = config.wayland.windowManager.sway.config.terminal;
	menu = config.wayland.windowManager.sway.config.menu;
      in {
        # ------------------ Keybinds ------------------
	
	# ------ Apps ------
        
	"${mod}+Return" = "exec ${terminal}";
        "${mod}+Space" = "exec ${menu}";
        "${mod}+q" = "kill";

	# ------ Login ------

	"${mod}+Shift+L" = "exec swaymsg exit";
	"${mod}+L" = "exec swaylock";

	# ------------ Window management ------------

        # ------ Movement ------

	"${mod}+Left" = "focus left";
	"${mod}+Right" = "focus right";
	"${mod}+Up" = "focus up";
	"${mod}+Down" = "focus down";

	# ------ Workspaces ------

	"${mod}+1" = "workspace number 1";
	"${mod}+2" = "workspace number 2";
        "${mod}+3" = "workspace number 3";
        "${mod}+4" = "workspace number 4";
        "${mod}+5" = "workspace number 5";
        "${mod}+6" = "workspace number 6";
        "${mod}+7" = "workspace number 7";
        "${mod}+8" = "workspace number 8";
        "${mod}+9" = "workspace number 9";
        "${mod}+0" = "workspace number 10";
	"${mod}+Shift+1" = "move container to workspace number 1";
	"${mod}+Shift+2" = "move container to workspace number 2";
	"${mod}+Shift+3" = "move container to workspace number 3";
	"${mod}+Shift+4" = "move container to workspace number 4";
	"${mod}+Shift+5" = "move container to workspace number 5";
	"${mod}+Shift+6" = "move container to workspace number 6";
	"${mod}+Shift+7" = "move container to workspace number 7";
	"${mod}+Shift+8" = "move container to workspace number 8";
	"${mod}+Shift+9" = "move container to workspace number 9";
	"${mod}+Shift+0" = "move container to workspace number 10";

	"${mod}+S" = "scratchpad show";
	"${mod}+Shift+S" = "move scratchpad";
      };
    };
  };

  home.stateVersion = "24.11";
}

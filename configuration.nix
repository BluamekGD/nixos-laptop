{ config, pkgs, hyprland, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.device = "nodev";
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  boot.loader.efi.canTouchEfiVariables = true;

  # Intel iGPU
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver
    intel-compute-runtime
  ];

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale / time
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";

  # User and shell
  users.users.bartek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
    initialPassword = "changeme";
  };

  programs.zsh.enable = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git wget curl neovim
    pciutils usbutils
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.hack
    nerd-fonts.noto
  ];

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    package = hyprland.packages.x86_64-linux.hyprland;
    portalPackage = hyprland.packages.x86_64-linux.xdg-desktop-portal-hyprland;
  };

  # Ly DM
  services.displayManager.ly.enable = true;

  # Wayland env vars
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  # Laptop power management
  services.tlp.enable = true;
  powerManagement.cpuFreqGovernor = "powersave";

  # Touchpad
  services.libinput.enable = true;

  # SSH
  services.openssh.enable = true;

  # Samba client
  services.gvfs.enable = true;

  system.stateVersion = "24.11";
}

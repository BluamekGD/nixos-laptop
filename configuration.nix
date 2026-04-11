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

  # User
  users.users.bartek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.bash;
    initialPassword = "changeme";
  };

  # System packages
  environment.systemPackages = with pkgs; [
    git wget curl ly
    pciutils usbutils
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

  # Xserver (needed for session files)
  services.xserver.enable = true;

  # Ly DM
  systemd.services.ly = {
    enable = true;
    description = "ly Display Manager";
    after = [ "systemd-user-sessions.service" ];
    wantedBy = [ "multi-user.target" ];
    conflicts = [ "getty@tty1.service" ];
    serviceConfig = {
      ExecStart = "${pkgs.ly}/bin/ly";
      StandardInput = "tty";
      TTYPath = "/dev/tty1";
      TTYReset = true;
      TTYVHangup = true;
    };
  };

  # PAM for ly
  security.pam.services.ly.enable = true;

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

  system.stateVersion = "24.11";
}

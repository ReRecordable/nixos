# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, lib, pkgs, modules, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
  ];

  # Enable support for those aetherial nix flakes.
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Various settings for the boot process.
  boot = {
    # initrd.systemd.enable = true;
    # Enable GRUB and configure it to support EFI
    loader = {
      timeout = 0;
      # systemd-boot.enable = true;
      grub = {
        enable = true;
        efiSupport = true;
        devices = [ "nodev" ];
      };
      efi.canTouchEfiVariables = true;
      efi.efiSysMountPoint = "/efi";
    };
  };

  # Set the system's hostname. This is the name that the system will go by when it comes to networking.
  networking.hostName = "nix5590";

  # Enable NetworkManager
  networking.networkmanager.enable = true;
  # networking.nftables.enable = true;

  # Declare fonts that will be available for use on the system.
  fonts.packages = with pkgs; [ font-awesome ultimate-oldschool-pc-font-pack ];

  # Set the time zone that the system will use.
  time.timeZone = "America/New_York";

  # "Locale" config. This option declares what language the system will be in.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # Use "xkb.options" in the tty environment.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the XFCE4 desktop and required dependancies. 
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.startx.enable = true;
  programs.nm-applet.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ]; 

  # Disable XTerm.
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.xserver.desktopManager.xterm.enable = false;

  # Graphics configuration
  hardware.graphics = {
    enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";
 
  # Define users & their passwords for the system.  users.users = {
  users.users = {
  # Personal Account.
    pilot = {
      # description = "To whom which will not be named";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "dialout" ]; # Enable ‘sudo’ for the user.
      packages = with pkgs; [ ];
    };
  };

  # Allow unfree packages available in the repo to be installed:
  nixpkgs.config.allowUnfree = true;

  # Packages installed system-wide. Search for more at "search.nixos.org" in the "Packages" tab.
  environment.systemPackages = with pkgs; [
    git
    google-chrome
    kitty
    neovim
    btop
    pciutils
    usbutils
    unzip
    youtube-music
    cava
    vesktop
    prismlauncher
    putty
    bluetuith
    firefox
    everforest-gtk-theme
    numix-icon-theme-square
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-docklike-plugin
  ];

  # Declare services that will be used on the system. Valid options can be found on "search.nixos.org" in the "NixOS Options" tab.

  # Disable the OpenSSH daemon. Reason: improve security.
  services.openssh.enable = false;

  # Enable "libinput".
  services.libinput.enable = true;

  ##  XFCE nonsense
  programs.thunar.enable = true;
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];

  # Enable several virtualisation services. Also enable a manager that will deal with both Xen VMs and LXC containers.
  # virtualisation = {
  #   # xen.enable = true;
  #   # lxc.enable = true;
  #   kvmgt.enable = true;
  #   libvirtd = {
  #     enable = true;
  #     # qemu.package = pkgs.qemu_xen;
  #   };
  # };
  # nix.settings.system-features = [ "kvm" ];
  # Enable Bluetooth support.
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable sound support with Pulseaudio instead of Pipewire.
  services.pipewire.enable = lib.mkForce false;
  services.pipewire.pulse.enable = lib.mkForce false;
  hardware.pulseaudio.enable = true;

  # Enable Flatpak support.
  services.flatpak.enable = true;
  
  # services.tlp.enable = true;

  # Enable PolKit to fix an issue with NetworkManager
  # security.polkit.enable = true;
  
  # Enable Cloudflare's "warp" proxy.
  services.cloudflare-warp.enable = true;
  
  # Enable Steam
  programs.steam.enable = true;

  # Disable the NixOS documentation (all of it is available online, and a NixOS install requires the internet.
  documentation.nixos.enable = false;

  # Options to configure ports controlled by the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Enable the firewall.
  networking.firewall.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value, unless you have did your homework and know what you're doing.
  system.stateVersion = "24.05"; # Did you read the comment?

}


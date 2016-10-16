# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  cfg = import ./vars.nix { inherit pkgs; };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.grub.enable = false;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.cleanTmpDir = true;
  boot.extraModprobeConfig = ''
    options libata.force=noncq
    options resume=/dev/sda3
    options snd_hda_intel index=0 model=intel-mac-auto id=PCH
    options snd_hda_intel index=1 model=intel-mac-auto id=HDMI
    options snd-hda-intel model=mbp101
    options hid_apple fnmode=2
  '';

  # TODO: update for your TZ
  time.timeZone = cfg.timeZone;

  # I like a good font selection...
  fonts.enableFontDir = true;
  fonts.enableCoreFonts = true;
  fonts.enableGhostscriptFonts = true;
  fonts.fonts = with pkgs; [
    corefonts
    inconsolata
    liberation_ttf
    dejavu_fonts
    bakoma_ttf
    gentium
    ubuntu_font_family
    terminus_font
  ];

  # Keep your environment sane
  nix.useSandbox = true;
  nix.binaryCaches = cfg.binaryCaches;

  networking.hostName = cfg.hostName;
  networking.firewall.enable = true;
  networking.wireless.enable = true;

  # TODO: enable bluetooth if you use it on your MBP, otherwise I
  # just disable to save on battery.
  hardware.bluetooth.enable = true;
  # This enables the facetime HD webcam on newer Macbook Pros (mid-2014+).
  hardware.facetimehd.enable = true;
  hardware.opengl.extraPackages = [ pkgs.vaapiIntel ];
  hardware.pulseaudio.enable = true;

  environment.variables = {
    #MY_ENV_VAR = "\${HOME}/bla/bla";
  };
  # minimize the number of systemPackages to essentials because
  # you should keep most of your apps in your user profile.
  environment.systemPackages = with pkgs; [
    # CLI tools
    screen
    tcpdump
    acpi
    vim
    git
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    linux = pkgs.linuxPackages.override {
      extraConfig = ''
        THUNDERBOLT m
      '';
    };
  };

  powerManagement.enable = true;

  programs.light.enable = true;
  programs.bash.enableCompletion = true;

  services.locate.enable = true;

  # Sensible to keep for powermanagement
  services.tlp.enable = true;

  services.xserver.enable = true;
  services.xserver.enableTCP = false;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "mac";
  #services.xserver.videoDrivers = [ "intel" ];
  services.xserver.xkbOptions = "terminate:ctrl_alt_bksp, ctrl:nocaps";

  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.displayManager.slim.enable = true;
  services.xserver.displayManager.slim.theme = pkgs.slimThemes.lake.src;

  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.enableContribAndExtras = true;

  services.xserver.multitouch.enable = true;
  services.xserver.multitouch.invertScroll = true;

  services.xserver.synaptics.additionalOptions = ''
    Option "VertScrollDelta" "-100"
    Option "HorizScrollDelta" "-100"
  '';
  services.xserver.synaptics.enable = true;
  services.xserver.synaptics.tapButtons = true;
  services.xserver.synaptics.fingersMap = [ 0 0 0 ];
  services.xserver.synaptics.buttonsMap = [ 1 3 2 ];
  services.xserver.synaptics.twoFingerScroll = true;

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = true;

  users.mutableUsers = true;
  users.ldap.daemon.enable = false;
  # TODO: update username and description, etc.
  users.extraUsers."${cfg.user}" = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    description = cfg.name;
    extraGroups = [ "wheel" "networkmanager" "systemd-journal" "disk" "audio" "video" ];
    createHome = true;
    home = "/home/${cfg.user}";
  };
}
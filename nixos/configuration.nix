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

  boot.kernelPackages = pkgs.linuxPackages_4_7;
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
    options hci reset=1
  '';
  # TODO: update for your TZ
  time.timeZone = cfg.timeZone;

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

  nix.useSandbox = true;
  nix.binaryCaches =
    [
      https://cache.nixos.org
    ];

  # TODO: Update
  networking.extraHosts = ''
  127.0.0.1 mydevbox.local
  '';
  #networking.nameservers = [ "8.8.4.4" "8.8.8.8" ];
  networking.hostName = "dkmbp0";
  networking.firewall.enable = true;
  networking.wireless.enable = true;

  # TODO: enable bluetooth if you use it on your MBP, otherwise I
  # just disable to save on battery.
  hardware.bluetooth.enable = false;
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
    hidapi
    emacs25
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    linux = pkgs.linuxPackages.override {
      extraConfig = ''
        THUNDERBOLT m
        CONFIG_SND_USB=y
        CONFIG_SND_USB_AUDIO=m
      '';
    };
  };

  powerManagement.enable = true;
  powerManagement.powerDownCommands = ''
    # disable XHC1 and ARPT for wakeup
    echo 'disable XHC1' > /proc/acpi/wakeup
    echo 'disable ARPT' > /proc/acpi/wakeup
    echo 'enable LID0'  > /proc/acpi/wakeup
  '';
  powerManagement.powerUpCommands = ''
    # disable XHC1 and ARPT for wakeup
    echo 'disable XHC1' > /proc/acpi/wakeup
    echo 'disable ARPT' > /proc/acpi/wakeup
    echo 'enable LID0'  > /proc/acpi/wakeup
  '';

  programs.light.enable = true;
  programs.bash.enableCompletion = true;

  services.acpid.enable = true;
  services.dnsmasq.enable = true;
  services.dnsmasq.extraConfig = ''
    address=/dev/127.0.0.1
    server=/prod/10.11.10.53
    server=/stage/10.10.10.53
  '';
  services.dnsmasq.servers = [
    "8.8.4.4"
    "8.8.8.8"
  ];

  services.locate.enable = true;
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandleLidSwitch=suspend
  '';
  services.openvpn.servers.prod = {
    autoStart = false;
    config = builtins.readFile ./vpn.prod.conf;
    up = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
    down = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
  };
  services.openvpn.servers.stage = {
    autoStart = true;
    config = builtins.readFile ./vpn.stage.conf;
    up = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
    down = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
  };

  #services.thermald.enable = true;

  services.tlp.enable = true;
  services.tlp.extraConfig = ''
    DISK_IDLE_SECS_ON_AC=0
    DISK_IDLE_SECS_ON_BAT=2

    MAX_LOST_WORK_SECS_ON_AC=15
    MAX_LOST_WORK_SECS_ON_BAT=60

    CPU_SCALING_GOVERNOR_ON_AC=performance
    CPU_SCALING_GOVERNOR_ON_BAT=powersave

    SCHED_POWERSAVE_ON_AC=0
    SCHED_POWERSAVE_ON_BAT=1

    DISK_IOSCHED="deadline cfq"

    SATA_LINKPWR_ON_AC=max_performance
    SATA_LINKPWR_ON_BAT=min_power

    PCIE_ASPM_ON_AC=performance
    PCIE_ASPM_ON_BAT=powersave

    WIFI_PWR_ON_AC=off
    WIFI_PWR_ON_BAT=on

    SOUND_POWER_SAVE_ON_AC=0
    SOUND_POWER_SAVE_ON_BAT=1

    RUNTIME_PM_ON_AC=on
    RUNTIME_PM_ON_BAT=auto

    USB_AUTOSUSPEND=1

    DEVICES_TO_ENABLE_ON_AC="bluetooth wifi wwan"
    DEVICES_TO_DISABLE_ON_BAT="wwan"
  '';

  services.xserver.enable = true;
  services.xserver.enableTCP = false;
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "mac";
  #services.xserver.videoDrivers = [ "intel" ];
  services.xserver.xkbOptions = pkgs.lib.concatStringsSep "," [
    "altwin2:cmd_n_ctrl"
    "terminate:ctrl_alt_bksp"
    "ctrl:nocaps"
  ];
  # TODO: uncomment and amend if you use an external monitor
  #services.xserver.xrandrHeads = [ "HDMI-0" "eDP" ];
  #services.xserver.resolutions = [
  #  { x = "3840"; y = "2160"; }
  #  { x = "2880"; y = "1800"; }
  #];

  services.xserver.desktopManager.default = "none";
  services.xserver.desktopManager.xterm.enable = false;

  services.xserver.displayManager.slim.enable = true;
  services.xserver.displayManager.slim.theme = pkgs.slimThemes.lake.src;

  services.xserver.windowManager.default = "xmonad";
  services.xserver.windowManager.xmonad.enable = true;
  services.xserver.windowManager.xmonad.extraPackages = hpkgs: with hpkgs; [
    xmonad
    xmonad-contrib
    xmonad-extras
    xmonad-utils
  ];

  services.xserver.multitouch.enable = true;
  services.xserver.multitouch.invertScroll = true;
  services.xserver.multitouch.tapButtons = true;

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

  system.activationScripts.gpe17disable = pkgs.lib.stringAfter [ "usrbinenv" ] ''
    # disable the ACPI interrupt problem on gep17
    "${pkgs.coreutils}/bin/echo" disable > /sys/firmware/acpi/interrupts/gpe17
  '';

  systemd.user.services.emacs = {
    description = "Emacs Daemon";
    environment = {
      GTK_DATA_PREFIX = config.system.path;
      SSH_AUTH_SOCK = "%t/gnupg/S.gpg-agent.ssh";
      GTK_PATH = "${config.system.path}/lib/gtk-3.0:${config.system.path}/lib/gtk-2.0";
      NIX_PROFILES = "${pkgs.lib.concatStringsSep " " config.environment.profiles}";
      TERMINFO_DIRS = "/run/current-system/sw/share/terminfo";
      ASPELL_CONF = "dict-dir /run/current-system/sw/lib/aspell";
    };
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.emacs25}/bin/emacs --daemon";
      ExecStop = "${pkgs.emacs25}/bin/emacsclient --eval (kill-emacs)";
      Restart = "always";
    };
    wantedBy = [ "default.target" ];
  };

  systemd.services.emacs.enable = true;

  users.mutableUsers = true;
  users.ldap.daemon.enable = false;
  users.extraUsers."${cfg.user}" = {
    isNormalUser = true;
    uid = 1000;
    group = "users";
    description = cfg.name;
    extraGroups = [
      "wheel"
      "networkmanager"
      "messagebus"
      "systemd-journal"
      "disk"
      "audio"
      "video"
      "docker"
    ];
    createHome = true;
    home = "/home/${cfg.user}";
  };

  virtualisation.docker.enable = true;
}

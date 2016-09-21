{ pkgs }:
{
  user = "spotter";
  name = "Susan Potter";
  hostName = "myhostname0";
  timeZone = "America/Chicago";
  binaryCaches = [
    https://cache.nixos.org
  ];

  extraConfig = {
    services.dnsmasq.enable = true;
    services.dnsmasq.extraConfig = ''
      address=/dev/127.0.0.1
      server=/prod.myalias/10.10.10.10
      server=/stage.myalias/10.11.10.10
    '';
    services.dnsmasq.servers = [
      # TODO: update to your internal nameservers
      "8.8.4.4"
      "8.8.8.8"
    ];

    services.openvpn.servers.prod = {
      autoStart = false;
      config = builtins.readFile ./vpn/prod.conf;
      up = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
      down = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
    };
    services.openvpn.servers.stage = {
      autoStart = true;
      config = builtins.readFile ./vpn/stage.conf;
      up = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
      down = "${pkgs.update-resolv-conf}/libexec/openvpn/update-resolv-conf";
    };
  };
}

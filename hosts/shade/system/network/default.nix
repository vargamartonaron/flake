{ lib, config, pkgs, ... }: {
  imports = [ ./spotify.nix ];

  networking = {
    # use quad9 with DNS over TLS
    nameservers = [ "9.9.9.9#dns.quad9.net" ];
    hostname = "shade";

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
      wifi.powersave = true;
    };
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };
}

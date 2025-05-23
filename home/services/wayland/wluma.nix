{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.wluma = {
    Unit = {
      Description = "Automatic backlight control";
      After = ["graphical-session.target"];
      Requires = ["graphical-session.target"];
    };
    Service = {
      ExecStart = lib.getExe pkgs.wluma;
      Restart = "on-failure";
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  xdg.configFile."wluma/config.toml".source = (pkgs.formats.toml {}).generate "wluma-config" {
    als.webcam = {
      thresholds = {
        "0" = "night";
        "20" = "dark";
        "80" = "dim";
        "250" = "normal";
        "500" = "bright";
        "800" = "outdoors";
      };
    };

    output.backlight = [
      {
        capturer = "wayland";
        name = "eDP-1";
        path = "/sys/class/backlight/intel_backlight";
      }
    ];

    # need to fix ddcutil first
    # output.ddcutil = [
    #   {
    #     capturer = "none";
    #     name = "BenQ BL2283";
    #   }
    # ];
  };
}

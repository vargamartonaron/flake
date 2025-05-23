{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "^(${elements})$";

      lowopacity = [
        "bar"
        "calendar"
        "notifications"
        "system-menu"
      ];

      highopacity = [
        "fuzzel"
        "obsidian"
        "spotify"
        "osd"
        "logout_dialog"
      ];

      blurred = lib.concatLists [
        lowopacity
        highopacity
      ];
    in [
      "blur, ${toRegex blurred}"
      "xray 1, ${toRegex ["bar"]}"
      "ignorealpha 0.5, ${toRegex (highopacity ++ ["music"])}"
      "ignorealpha 0.2, ${toRegex lowopacity}"
    ];

    # window rules
    windowrulev2 = [
      
      "float, class: ^(Zotero)$"
      "float, class: ^Bluetooth-Devices$"
      "float, class: fuzzel"
      "float, class: ^(blueman-manager)$"
      "float, class: ^(xdg-desktop-portal-gtk)$"
      "float, title: pavucontrol"
      # make Firefox/Zen PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(Zen — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # start spotify in ws9
      "workspace 9 silent, title:^(Spotify( Premium)?)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(vlc)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"

      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(hyprpolkitagent)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "nofocus, title:(.*is sharing (your screen | a window))"

    ];
  };
}

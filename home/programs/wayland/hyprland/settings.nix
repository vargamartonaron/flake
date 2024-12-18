{config, ...}: let
  pointer = config.home.pointerCursor;

  cursorName = "catppuccin-mocha-light-cursors";
in {
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER";
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString pointer.size}"
    ];

    exec-once = [
      # set cursor for HL itself
      "hyprctl setcursor ${cursorName} ${toString pointer.size}"
      "hyprlock"
      "nm-applet"
      "blueman-applet"
      "waybar"
      "dunst"
    ];

    general = {
      layout = "dwindle";
      gaps_in = 5;
      gaps_out = 20;
      border_size = 2;
      "col.active_border" = "rgba(FFFFFFFF) rgba(808080ee) 45deg";
      "col.inactive_border" = "rgba(202020FF)";

      no_focus_fallback = true;

      allow_tearing = true;
      resize_on_border = true;
    };

    decoration = {
      rounding = 12;
      
      active_opacity = 1.0;
      dim_inactive = true;
      dim_strength = 0.4;

      drop_shadow = true;
      shadow_range = 12;
      shadow_render_power = 6;
      "col.shadow" = "rgba(FFFFFF55)";
      "col.shadow_inactive" = "rgba(000000FF)";

      blur = {
        enabled = true;
        brightness = 1.0;

        vibrancy = 1.0;

        passes = 3;
        size = 10;

        popups = true;
        popups_ignorealpha = 0.2;
      };
    };

    animations = {
      enabled = true;
      bezier = "overshot, 0.13, 0.99, 0.29, 1.1";
      animation = [
        "border, 1, 10, default"
        "borderangle, 1, 8, default"
        "fade, 1, 10, default"
        "windows, 1, 4, overshot, popin"
        "windowsOut, 1, 7, default, popin 80%"
        "workspaces, 1, 6, overshot, slide"
      ];
    };

    group = {
      groupbar = {
        font_size = 10;
        gradients = false;
        text_color = "rgb(FFFFFF)";
      };

      "col.border_active" = "rgba(FFFFFF55)";
      "col.border_inactive" = "rgba(000000FF)";
    };

    input = {
      kb_layout = "us";

      # focus change on cursor move
      follow_mouse = 1;
      accel_profile = "flat";
      touchpad.scroll_factor = 0.1;
    };

    dwindle = {
      # keep floating dimensions while tiling
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;
    };

    render.direct_scanout = true;

    # touchpad gestures
    gestures = {
      workspace_swipe = true;
      workspace_swipe_forever = true;
    };

    xwayland.force_zero_scaling = true;

    debug.disable_logs = false;


    hyprbars = {
      bar_height = 20;
      bar_precedence_over_border = true;

      # order is right-to-left
      hyprbars-button = [
        # close
        "rgba(000000FF), 15, , hyprctl dispatch killactive"
        # maximize
        "rgb(000000FF), 15, , hyprctl dispatch fullscreen 1"
      ];
    };

    hyprexpo = {
      columns = 3;
      gap_size = 4;
      bg_col = "rgb(000000)";

      enable_gesture = true;
      gesture_distance = 300;
      gesture_positive = false;
    };
  };
 }

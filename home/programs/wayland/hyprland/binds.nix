{lib, ...}: let
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (builtins.genList (
      x: let
        ws = let
          c = (x + 1) / 10;
        in
          builtins.toString (x + 1 - (c * 10));
      in [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    )
    10);

  toggle = program: service: let
    prog = builtins.substring 0 14 program;
    runserv = lib.optionalString service "systemd-run --user --collect";
  in "pkill ${prog} || ${runserv} ${program}";

  runOnce = program: "pgrep ${program} || ${program}";
in {
  wayland.windowManager.hyprland.settings = {
    # binds
    bind =
      [
        # compositor commands
        "$mod SHIFT, E, exec, hyprctl dispatch exit"
        "$mod, Q, killactive,"
        "$mod, F, fullscreen,"
        "$mod SHIFT, F, fullscreen, 0"
        "$mod, G, togglegroup,"
        "$mod SHIFT, N, changegroupactive, f"
        "$mod SHIFT, P, changegroupactive, b"
        "$mod, R, togglesplit,"
        "$mod, T, togglefloating,"
        "$mod, P, pseudo,"

        # utility
        "$mod, B, exec, firefox"
        # terminal
        "$mod, Return, exec, kitty"
        # logout menu
        "$mod, Escape, exec, ${toggle "wlogout" true} -p layer-shell"
        # lock screen
        "$mod, L, exec, pgrep hyprlock || hyprlock"
        # fuzzel
        "$mod, D, exec, fuzzel"

        # move focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # screenshot
        # area
        ", Print, exec, ${runOnce "grimblast"} --notify copysave area"
        "$mod SHIFT, R, exec, ${runOnce "grimblast"} --notify copysave area"

        # current screen
        "CTRL, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave output"
        "$mod SHIFT CTRL, R, exec, ${runOnce "grimblast"} --notify --cursor copysave output"

        # all screens
        "ALT, Print, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"
        "$mod SHIFT ALT, R, exec, ${runOnce "grimblast"} --notify --cursor copysave screen"

        # special workspace
        "$mod SHIFT, grave, movetoworkspace, special"
        "$mod, grave, togglespecialworkspace, current"

        # cycle workspaces
        "$mod, bracketleft, workspace, m-1"
        "$mod, bracketright, workspace, m+1"

        # cycle monitors
        "$mod SHIFT, bracketleft, focusmonitor, l"
        "$mod SHIFT, bracketright, focusmonitor, r"

        # send focused workspace to left/right monitors
        "$mod SHIFT ALT, bracketleft, movecurrentworkspacetomonitor, l"
        "$mod SHIFT ALT, bracketright, movecurrentworkspacetomonitor, r"
      ]
      ++ workspaces;

    bindl = [
      # media controls
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
      ", XF86AudioNext, exec, playerctl next"

      # volume
      ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    ];

    bindle = [
      # volume
      ", XF86AudioRaiseVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+"
      ", XF86AudioLowerVolume, exec, wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-"

      # backlight
      ", XF86MonBrightnessUp, exec, brillo -q -u 300000 -A 5"
      ", XF86MonBrightnessDown, exec, brillo -q -u 300000 -U 5"
    ];

    bindm = [
      "$mod, mouse:273, resizewindow"
      "$mod, mouse:272, movewindow"
    ];
  };
}

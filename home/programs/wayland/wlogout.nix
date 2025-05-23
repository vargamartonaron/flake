{
  pkgs,
  lib,
  ...
}: let
  bgImageSection = name: ''
    #${name} {
      background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/${name}.png"));
    }
  '';
in {
  programs.wlogout = {
    enable = true;

    style = ''
      * {
        background: none;
      }

      window {
      	background-color: rgba(0, 0, 0, .95);
        font-family: Terminess Nerd Font;
        font-size: 11pt;
      }

      button {
        color: rgba(255, 255, 255, .9);
        background: rgba(0, 0, 0, .05);
        box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .1), 0 0 rgba(0, 0, 0, .95);
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        transition: box-shadow .2s ease-in-out, background-color 0.2s ease-in-out;
      }

      button:focus, button:active, button:hover {
        background-color: rgba(255, 255, 255, 0.2);
        outline-style: none;
      }


      ${lib.concatMapStringsSep "\n" bgImageSection [
        "lock"
        "logout"
        "suspend"
        "hibernate"
        "shutdown"
        "reboot"
      ]}
    '';
  };
}

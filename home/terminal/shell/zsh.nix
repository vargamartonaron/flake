{ config, pkgs, lib, inputs, ... }: {
  home.packages = with pkgs; [
    nix-zsh-completions
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    autocd = true;
    dotDir = ".config/zsh";

    history = {
      expireDuplicatesFirst = true;
      path = "${config.xdg.dataHome}/.zsh_history";
    };
     
    zplug = {
      enable = true;
      plugins = [
        {name = "zsh-users/zsh-autosuggestions";}
        {name = "zsh-users/zsh-syntax-highlighting";}
        {name = "zsh-users/zsh-completions";}
        {name = "romkatv/zsh-defer";}
      ];
    };

    shellAliases = {
      eltehpc = "kitty +kitten ssh -i ~/.ssh/eltehpc usumusu@atlasz.elte.hu";
      eltehvpn = "sudo openfortivpn fw1.vpn.elte.hu:4443 -u usumusu --ca-file=/home/usu/Downloads/elte-ca.crt";
      eltevpnstop = "sudo killall openfortivpn";
      ssh = "kitty +kitten ssh";
      c = "clear";
      q = "exit";
      cleanram = "sudo sync && echo 3 | sudo tee /proc/sys/vm/drop_caches";
      trim_all = "sudo fstrim -av";
      mtar = "tar -zcvf"; # mtar <archive_compress>
      utar = "tar -zxvf"; # utar <archive_decompress> <file_list>
      zip = "zip -r"; # zip <archive_name> <file_list>
      ".." = "cd ..";
      mkdir = "mkdir -p";
      fm = "yazi";
      ls = "exa --color=auto --icons --git";
      l = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      cat = "bat --color always --plain";
      grep = "grep --color=auto";
      mv = "mv -v";
      cp = "cp -vr";
      gst = "git status";
      gcmsg = "git commit -m";
      ip = "ip --color";
     };
     
    initExtra = ''
      bindkey "''${key[Up]}" up-line-or-search

      if [[ $(tty) == /dev/tty1 ]]; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
  };
  programs.bat.enable = true;
}

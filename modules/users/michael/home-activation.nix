{ self, inputs, ... }:

let
  username = "michael";
  shellAliases = {
    gs = "git status";
    ".." = "cd ..";
    ls = "ls -alh";
  };
  # home-dir = "$HOME";
in

{

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules."${username}-activation-module" = { pkgs, config, lib, ... }: {

    # home.file."${config.home.homeDirectory}/.face".source = ./payload/face_nixos.jpg;
    # the .icon is for sddm when logged in
    # home.file."${config.home.homeDirectory}/.face.icon".source = ./payload/face_nixos.jpg;
    # home.file."/var/lib/AccountsService/icons/nixos".source = ./payload/face_nixos.jpg;
    # links to /home/${USER}:
    home.file."${config.xdg.configHome}/Pictures/Wallpapers" = {
    # links to /home/${USER}/.config:
    # home.file."${config.home.homeDirectory}/Pictures/Wallpapers" = {
      # source = ../payload/Wallpapers;
      source = ../../../modules/system/payload/Wallpapers;
      recursive = true;
    };


    # XDG User dirs: https://github.com/NixOS/nixpkgs/issues/33282
    xdg = {
      enable = true;
      userDirs.enable = true;
      # userDirs.setSessionVariables = true;
      userDirs.createDirectories = false;
      userDirs.extraConfig = {
        GIT = "${config.home.homeDirectory}/git";
        GIT_REPOS = "${config.home.homeDirectory}/git/repos";
        VENV = "${config.home.homeDirectory}/git/venv";
    #    XDG_GOOGLEDRIVE_DIR = "${home-dir}/GoogleDrive";
        KDRIVE = "${config.home.homeDirectory}/kDrive";
        WALLPAPERS = "${config.home.homeDirectory}/Pictures/Wallpapers";
      };
    };

    # https://mynixos.com/home-manager/option/home.activation
    home.activation = {
      myActivationAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # run ln -s $VERBOSE_ARG ${builtins.toPath ./link-me-directly} $HOME
      # /nix/store/s684h4kq0l8jdfsp5lsd46i3a7mwa9xq-source/link-me-directly
      run mkdir -p $HOME/kDrive;
      run mkdir -p $HOME/git/repos;
      run mkdir -p $HOME/git/venv;
      run mkdir -p $HOME/gPodder;
      run mkdir -p $HOME/gPodder;
      run mkdir -p $HOME/Documents/Obsidian;
      run mkdir -p $HOME/Calibre;
      run mkdir -p $HOME/VM/QEMU;
      run mkdir -p $HOME/VM/VirtualBox;
      run mkdir -p $HOME/VM/VMWare;

      run ln -s /data $HOME/ &> /dev/null || echo "~/data already exists"
      # run ln -s /data $HOME/ &> /dev/null || echo "~/data already exists"
      # it might point to the wrong directory and it won't get re-created
      # force re-creation?
      run ln -s ${builtins.toPath ../payload/Wallpapers} ${config.home.homeDirectory}/Pictures/ &> /dev/null || echo "~/Pictures/Wallpapers already exists"
      run ln -sfn /var/lib/AccountsService/icons/${config.home.username} ${config.home.homeDirectory}/.face &> /dev/null || echo "~/Pictures/Wallpapers already exists"
      run ln -sfn /var/lib/AccountsService/icons/${config.home.username} ${config.home.homeDirectory}/face.icon &> /dev/null || echo "~/Pictures/Wallpapers already exists"
      '';
    };

  };

}

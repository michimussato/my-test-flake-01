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
    # home.file."${config.xdg.configHome}/Pictures/Wallpapers" = {
    # links to /home/${USER}/.config:
    home.file."${config.home.homeDirectory}/Pictures/Wallpapers" = {
      # source = ../payload/Wallpapers;
      source = ../../system/payload/Wallpapers;
      recursive = true;
    };

    home.sessionVariables = {
      EDITOR = "emacs";
    };

    # XDG User dirs: https://github.com/NixOS/nixpkgs/issues/33282
    xdg = {
      enable = true;
      userDirs.enable = true;
      userDirs.setSessionVariables = true;
      userDirs.createDirectories = true;
      userDirs.extraConfig = {
        # Resulting variables will be pre- and post-fixed:
        # XDG_<VAR>_DIR
        GIT = "${config.home.homeDirectory}/git";
        GIT_REPOS = "${config.home.homeDirectory}/git/repos";
        VENV = "${config.home.homeDirectory}/git/venv";
        KDRIVE = "${config.home.homeDirectory}/kDrive";
        WALLPAPERS = "${config.home.homeDirectory}/Pictures/Wallpapers";
        SCREENSHOTS = "${config.home.homeDirectory}/Pictures/Screenshots";
        SCREENCASTS = "${config.home.homeDirectory}/Videos/Screencasts";
        GPODDER = "${config.home.homeDirectory}/gPodder";
        OBSIDIAN = "${config.home.homeDirectory}/Obsidian";
        CALIBRE = "${config.home.homeDirectory}/Calibre";
        # TEST = "${config.home.homeDirectory}/Test";
        VIRTUAL_MACHINES_ROOT = "${config.home.homeDirectory}/Virtual Machines";
        VIRTUAL_MACHINES_QEMU = "${config.home.homeDirectory}/Virtual Machines/qemu";
        VIRTUAL_MACHINES_VIRTUALBOX = "${config.home.homeDirectory}/Virtual Machines/VirtualBox";
        VIRTUAL_MACHINES_VMWARE = "${config.home.homeDirectory}/Virtual Machines/VMWare";
      };
    };

    # https://mynixos.com/home-manager/option/home.activation
    home.activation = {
      myActivationAction = lib.hm.dag.entryAfter ["writeBoundary"] ''
      # run ln -s $VERBOSE_ARG ${builtins.toPath ./link-me-directly} $HOME
      # /nix/store/s684h4kq0l8jdfsp5lsd46i3a7mwa9xq-source/link-me-directly
      # XDG variables don't seem to be available yet
      # at this stage
      # run mkdir -p "$XDG_TEST_DIR"/subdir;
      # run mkdir -p "$XDG_VIRTUAL_MACHINES_DIR"/QEMU;
      # run mkdir -p "$XDG_VIRTUAL_MACHINES_DIR"/VirtualBox;
      # run mkdir -p "$XDG_VIRTUAL_MACHINES_DIR"/VMWare;

      run ln -s /data $HOME/ &> /dev/null || echo "~/data already exists"
      # run ln -s /data $HOME/ &> /dev/null || echo "~/data already exists"
      # it might point to the wrong directory and it won't get re-created
      # force re-creation?
      # it seems like the files themselves instead of the Wallpapers
      # directory get linked
      # don't know yet why, but I guess it's even better this way.
      run ln -sfn ${builtins.toPath ../payload/Wallpapers} ${config.home.homeDirectory}/Pictures/ &> /dev/null || echo "~/Pictures/Wallpapers already exists"
      run ln -sfn /var/lib/AccountsService/icons/${config.home.username} ${config.home.homeDirectory}/.face &> /dev/null || echo "~/Pictures/Wallpapers already exists"
      run ln -sfn /var/lib/AccountsService/icons/${config.home.username} ${config.home.homeDirectory}/face.icon &> /dev/null || echo "~/Pictures/Wallpapers already exists"
      '';
    };

  };

}

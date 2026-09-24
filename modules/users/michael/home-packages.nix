{ self, inputs, ... }:

let
  username = "michael";
in

{

  # This is your home.nix, your module where you configure home-manager
  # It's imported both in standalone configuration above, and in your nixos configuration
  flake.homeModules."${username}-packages-module" = { pkgs, ... }: {

    home.packages = [
      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
      # pkgs.fzf
      pkgs.polychromatic
      pkgs.rawtherapee
      pkgs.darktable
      pkgs.gimp
      pkgs.gpodder
      pkgs.krita
      pkgs.handbrake
      pkgs.vlc
      pkgs.transmission_4-gtk
      pkgs.transmission-remote-gtk
      pkgs.spek
      pkgs.xournalpp
      pkgs.signal-desktop
      pkgs.djv
      pkgs.jetbrains.pycharm
      pkgs.podman-desktop
  #    pkgs.devenv
  #    pkgs.mpv
    ];
  };

}

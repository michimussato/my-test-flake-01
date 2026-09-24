# an example for github:numtide/devshell shells (see flake.nix also)

{ inputs, ... }:

{
  imports = [ inputs.devshell.flakeModule ];

  perSystem =
    { pkgs, ... }:

    let
      pkgs-base = with pkgs; [
        # fhs shell
        (pkgs.buildFHSEnv {
          name = "fhs";
          runScript = "bash";
          targetPkgs = pkgs: (with pkgs; [
            udev
            alsa-lib
            libX11
            libXrender
            libXfixes
            libXi
            libxkbcommon
            libSM
            libICE
            libGL
          ]);
        }
      )
    ];
  in

  {
    devshells = {
      blender-3 = {
        packages = pkgs-base;
        name = "blender-3";
        motd = ''
          You are now in a Blender 3 configured environment.
        '';
        devshell.startup.fhs.text = ''
          exec fhs
        '';
        # Custom Env:
        env = [
          {
            name = "DEV_SHELL";
            value = "blender-3";
          }
          {
            name = "PATH";
            prefix = "$HOME/Downloads/blender-5.2.1-linux-x64";
          }
        ];
      };
      blender-4 = {
        packages = pkgs-base;
        name = "blender-4";
        motd = ''
          You are now in a Blender 4 configured environment.
        '';
        devshell.startup.fhs.text = ''
          exec fhs
        '';
        # Custom Env:
        env = [
          {
            name = "DEV_SHELL";
            value = "blender-4";
          }
        ];
      };
      blender-5 = {
        packages = pkgs-base;
        name = "blender-5";
        motd = ''
          You are now in a Blender 5 configured environment.
        '';
        devshell.startup.fhs.text = ''
          exec fhs
        '';
        # Custom Env:
        env = [
          {
            name = "DEV_SHELL";
            value = "blender-5";
          }
          {
            name = "PATH";
            prefix = "/home/nixos/Downloads/blender-5.2.1-linux-x64";
          }
        ];
      };
    };
  };
}
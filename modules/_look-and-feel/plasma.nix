# https://github.com/Doc-Steve/dendritic-design-with-flake-parts/blob/main/flake.nix

{ inputs, self, ... }:

{

  flake = {

    modules.nixos.look-and-feel-plasma = { pkgs, ... }:

    {

#      config = lib.mkIf config.managedPlasma.enable {
      config = {
          programs = {
            plasma = rec {
              enable = true;
              # https://nix-community.github.io/plasma-manager/options.html#opt-programs.plasma.workspace.colorScheme
              # https://github.com/nix-community/plasma-manager/blob/trunk/modules/workspace.nix
              # - plasma-apply-colorscheme --list-schemes
              # https://thedocumentation.org/plasma-manager/configuration/workspace/
              workspace = {
                colorScheme = "BreezeDark";
                lookAndFeel = "org.kde.breezedark.desktop";
                # wallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/eskof_bubble_vignetted.png";
              };
              # etc.

              #
              # KRunner
              #
              krunner = {
                position = "center";
              };

              panels = [
                {
                  location = "bottom";
                  height = 26;
                  floating = false;
      #            widgets = [
      #              # ... widgets go here
      #            ];
                }
              ];

              # System Settings > Keyboard > Keyboard
              input.keyboard = {
                numlockOnStartup = "on";
                # options = ["ctrl:nocaps"];
              };

              kwin = {
                # System Settings > Window Management > Desktop Effects > ...
                effects = {
                  blur = {
                    enable = true;
                    noiseStrength = 0;
                    strength = 6;
                  };

                  slideBack.enable = true;

                  translucency.enable = true;

                  wobblyWindows.enable = true;
                };

                # System Settings > Window Management > Virtual Desktops
                virtualDesktops = {
                  number = 4;
                  rows = 1;
                };

                # scripts.polonium = {
                #   # Still only works in Plasma 5
                #   enable = true;
                #   settings = {
                #     layout.engine = "binaryTree";
                #     borderVisibility = "noBorderTiled";
                #   };
                # };
              };

              # System Settings > Screen Locking > Configure Appearance
              kscreenlocker = {
                appearance = {
                  showMediaControls = true;
      #            wallpaperPictureOfTheDay.provider = "bing";
                };
                # appearance.wallpaper = workspace.wallpaper;
              };
              #
              # Configuration Files (Order alphabetically)
              #
              configFile = {
      #          # System Settings > Search > File Search
      #          baloofilerc."Basic Settings"."Indexing-Enabled" = false;

                # GUI setting unknown
                # Use detailed view for file picker
                kdeglobals."KFileDialog Settings"."View Style" = "Detail";
                dolphinrc.General.EditableUrl = true;
                dolphinrc.General.ShowFullPath = true;
                dolphinrc.General.ShowFullPathInTitleBar = true;
                dolphinrc.General.ShowStatusBar = "FullWidth";
                dolphinrc.General.ShowZoomSlider = true;

                # System Settings > Colors & Themes > Splash Screen
                ksplashrc.KSplash = {
                  Engine = "none";
                  Theme = "None";
                };

      #          kwinrc = {
      #            # System Settings > Window Management > Desktop Effects > Geometry Change
      #            # Add Geometry Change: System Settings > Window Management > Desktop Effects >
      #            #   Get New...
      #            Effect-kwin4_effect_geometry_change."Duration" = 500;
      #          };

      #          # Spectacle > Configure Spectacle
      #          "spectaclerc"."General"."launchAction" = "DoNotTakeScreenshot";
              };
      #      };

            };
          };
        };

    };

  };

}

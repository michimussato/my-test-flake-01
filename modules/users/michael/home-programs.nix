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
  flake.homeModules."${username}-programs-module" = { pkgs, ... }: {

    programs.bash = {
      enable = true;
      inherit shellAliases;
    };

    programs.firefox = {
      enable = true;
      profiles = {
        "default" = {
          id = 0;  # 0 is default
          path = "myprofile.default";
          search.default = "ddg";
          settings = {
            "browser.aboutConfig.showWarning" = false;
          };
          # bookmarks = [
          #   {
          #     name = "wikipedia";
          #     tags = [ "wiki" ];
          #     keyword = "wiki";
          #     url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&amp;go=Go";
          #   }
          #   {
          #     name = "kernel.org";
          #     url = "https://www.kernel.org";
          #   }
          #   "separator"
          #   {
          #     name = "Nix sites";
          #     toolbar = true;
          #     # bookmarks = [
          #     #   {
          #     #     name = "homepage";
          #     #     url = "https://nixos.org/";
          #     #   }
          #     #   {
          #     #     name = "wiki";
          #     #     tags = [ "wiki" "nix" ];
          #     #     url = "https://wiki.nixos.org/";
          #     #   }
          #     # ];
          #   }
          # ];
        };
        # "test-default" = {
        #   id = 3;
        #   path = config.home.username;
        #   search.default = "ddg";
        #   settings = {
        #     "browser.aboutConfig.showWarning" = false;
        #   };
        # };
      };
    };

    services.flameshot = {
      enable = true;
      # https://mynixos.com/home-manager/option/services.flameshot.settings
      settings = {
        General = {
          disabledTrayIcon = false;
          showStartupLaunchMessage = false;
        };
      };
    };

    programs.obsidian = {
      enable = true;
      cli.enable = true;
    };

    programs.mpv = {
      enable = true;
    };

    programs.neovim = {
      enable = true;
    };

    # https://mynixos.com/search?q=fzf+home-manager
    programs.fzf = {
      # package = pkgs.fzf;
      enable = true;
      enableBashIntegration = true;
    };

    # https://mynixos.com/search?q=obs-studio+home-manager
    programs.obs-studio = {
      enable = true;
    };

    # https://wiki.nixos.org/wiki/Git#User-level_configuration_with_Home_Manager
    programs.git = {
      lfs.enable = true;
      enable = true;
      settings = {
        user = {
          email = "michimussato@etik.com";
          name = "Michael Mussato";
        };
        init.defaultBranch = "main";
      };
    };

    # https://mynixos.com/search?q=gitui+home-manager
    programs.gitui = {
      enable = true;
    };

    programs.calibre = {
      enable = true;
    };

#    programs = {
#      plasma = rec {
#        enable = true;
#        # https://nix-community.github.io/plasma-manager/options.html#opt-programs.plasma.workspace.colorScheme
#        # https://github.com/nix-community/plasma-manager/blob/trunk/modules/workspace.nix
#        # - plasma-apply-colorscheme --list-schemes
#        # https://thedocumentation.org/plasma-manager/configuration/workspace/
#        workspace = {
#          colorScheme = "BreezeDark";
#          lookAndFeel = "org.kde.breezedark.desktop";
##          wallpaper = "${config.home.homeDirectory}/Pictures/Wallpapers/eskof_bubble_vignetted.png";
#        };
#        # etc.
#
#        #
#        # KRunner
#        #
#        krunner = {
#          position = "center";
#        };
#
#        panels = [
#          {
#            location = "bottom";
#            height = 26;
#            floating = false;
##            widgets = [
##              # ... widgets go here
##            ];
#          }
#        ];
#
#        # System Settings > Keyboard > Keyboard
#        input.keyboard = {
#          numlockOnStartup = "on";
#          # options = ["ctrl:nocaps"];
#        };
#
#        kwin = {
#          # System Settings > Window Management > Desktop Effects > ...
#          effects = {
#            blur = {
#              enable = true;
#              noiseStrength = 0;
#              strength = 6;
#            };
#
#            slideBack.enable = true;
#
#            translucency.enable = true;
#
#            wobblyWindows.enable = true;
#          };
#
#          # System Settings > Window Management > Virtual Desktops
#          virtualDesktops = {
#            number = 4;
#            rows = 1;
#          };
#
#          # scripts.polonium = {
#          #   # Still only works in Plasma 5
#          #   enable = true;
#          #   settings = {
#          #     layout.engine = "binaryTree";
#          #     borderVisibility = "noBorderTiled";
#          #   };
#          # };
#        };
#
#        # System Settings > Screen Locking > Configure Appearance
#        kscreenlocker = {
#          appearance = {
#            showMediaControls = true;
##            wallpaperPictureOfTheDay.provider = "bing";
#          };
##          appearance.wallpaper = workspace.wallpaper;
#          # autoLock = false;
#          # timeout = 0;
#        };
#        #
#        # Configuration Files (Order alphabetically)
#        #
#        configFile = {
##          # System Settings > Search > File Search
##          baloofilerc."Basic Settings"."Indexing-Enabled" = false;
#
#          # GUI setting unknown
#          # Use detailed view for file picker
#          kdeglobals."KFileDialog Settings"."View Style" = "Detail";
#          dolphinrc.General.EditableUrl = true;
#          dolphinrc.General.ShowFullPath = true;
#          dolphinrc.General.ShowFullPathInTitleBar = true;
#          dolphinrc.General.ShowStatusBar = "FullWidth";
#          dolphinrc.General.ShowZoomSlider = true;
#
#          # System Settings > Colors & Themes > Splash Screen
#          ksplashrc.KSplash = {
#            Engine = "none";
#            Theme = "None";
#          };
#
##          kwinrc = {
##            # System Settings > Window Management > Desktop Effects > Geometry Change
##            # Add Geometry Change: System Settings > Window Management > Desktop Effects >
##            #   Get New...
##            Effect-kwin4_effect_geometry_change."Duration" = 500;
##          };
#
##          # Spectacle > Configure Spectacle
##          "spectaclerc"."General"."launchAction" = "DoNotTakeScreenshot";
#        };
##      };
#
#      };
#    };

  };

}

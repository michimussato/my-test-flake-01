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

  };

}

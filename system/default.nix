{ ... }: {
  flake.modules.nixosConfiguration.root = {pkgs, ...}: {
    users.users.root = {
      initialPassword = "root";
    };
  };
}

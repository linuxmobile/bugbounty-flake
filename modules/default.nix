{
  pkgs,
  system,
}: {
  packages = builtins.listToAttrs (
    map (
      file:
        let name = builtins.replaceStrings [".nix" "-"] ["" ""] file;
        in {
          name = name;
          value = import (./packages/${file}) { inherit pkgs; };
        }
    ) (builtins.filter (
      file: builtins.match ".*\.nix$" file != null
    ) (builtins.attrNames (builtins.readDir ./packages)))
  );

  scripts = import ./scripts {
    inherit pkgs;
  };
}

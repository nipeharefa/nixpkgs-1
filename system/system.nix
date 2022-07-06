{ config, pkgs, lib, ... }:
{
  # https://github.com/nix-community/home-manager/issues/423
  programs.nix-index.enable = true;
  # Nix configuration ------------------------------------------------------------------------------

  # Bootstrap
  nix = {
    binaryCaches = [
      "https://cache.nixos.org/"
      # using cachix from r17
      "https://r17.cachix.org/"
    ];

    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # using cachix from r17
      "r17.cachix.org-1:vz0nG6BCbdgTPn7SEiOwe/3QwvjH1sb/VV9WLcBtkAY="
    ];

    trustedUsers = [
      "@admin"
    ];

    # enable garbage-collection on weekly and delete-older-than 30 day
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    # this is configuration for /etc/nix/nix.conf
    # so it will generated /etc/nix/nix.conf
    extraOptions = ''
      auto-optimise-store = true
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '' + lib.optionalString (pkgs.system == "aarch64-darwin") ''
      extra-platforms = x86_64-darwin aarch64-darwin
    '';
  };

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 4;
    # Keyboard
    keyboard.enableKeyMapping = true;
    keyboard.remapCapsLockToEscape = true;
    # Add ability to used TouchID for sudo authentication
  };


  # Secrets management file
  age.secrets.r17.file = "${config.home.user-info.nixConfigDirectory}/secrets/r17.age";
}

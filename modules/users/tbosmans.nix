{
  flake.nixosModules.user-tbosmans = {
    users.users.tbosmans = {
      isNormalUser = true;
      uid = 1000;
      hashedPassword = "$y$j9T$CFXZEUSxYXBhdGxt0OK2U0$pUqQ6svHOSUtpB5R8quh3GiXYjOFRQOItIxV8B0Dsn1";
      extraGroups = [ "wheel" ];
    };
  };
}

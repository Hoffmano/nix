{
  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        device = "nodev";
        enable = true;
        efiSupport = true;
        useOSProber = true;
      };
    };
    kernelParams = [ "consoleblank=10" ];
  };
}

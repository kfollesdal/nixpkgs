{ config, lib, pkgs, ... }:

with lib;
{
  #imports = [ ../profiles/headless.nix ];

  users.users."root".initialHashedPassword = "$6$jAF.N3qAPwUFXf2m$qz/pbdPcJylkekMBdDTwriF9xdzL4b38ahhXFxhxF19iLlxOetiiMXHupug7C7/hDR08gsPMUcntVYQ0XRc8S/";
  users.users."root".hashedPassword = config.users.users."root".initialHashedPassword;

  boot.kernelParams = [
    # Kernel parameters recommende for Azure [1] and [3]
    "rootdelay=300"
    "console=ttyS0,115200" # [3]
    "earlyprintk=ttyS0"
    "net.ifnames=0"

    # Since we can't manually respond to a panic, just reboot.
    "panic=1"
    "boot.panic_on_fail"
  ];

  # Azure VM runs on Hyper-V hypervisor [2].
  # Follwoing config is form nixos-generate-config for hyper-v
  virtualisation.hypervGuest.enable = true;
  boot.initrd.availableKernelModules = [ "sd_mod" "sr_mod" ];
  networking.useDHCP = lib.mkDefault true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  # Generate a GRUB menu.
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.version = 2;
  #boot.loader.timeout = 0;

  boot.growPartition = true;

  # Don't put old configurations in the GRUB menu.  The user has no
  # way to select them anyway.
  #boot.loader.grub.configurationLimit = 0;

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
    autoResize = true;
  };

  # Allow root logins only using the SSH key that the user specified
  # at instance creation time, ping client connections to avoid timeouts
  services.openssh.enable = true;
  services.openssh.permitRootLogin = "prohibit-password";
  services.openssh.extraConfig = ''
    ClientAliveInterval 180
  '';

  # Force getting the hostname from Azure
  networking.hostName = mkDefault "";

  # Always include cryptsetup so that NixOps can use it.
  # sg_scan is needed to finalize disk removal on older kernels
  environment.systemPackages = [ pkgs.cryptsetup pkgs.sg3_utils ];

  networking.usePredictableInterfaceNames = false;

}
/*
REFERENCES
  1. https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-upload-generic#general-linux-system-requirements
  2. https://docs.microsoft.com/en-us/azure/virtual-machines/linux/create-upload-generic#installing-kernel-modules-without-hyper-v
  3. https://docs.microsoft.com/en-us/troubleshoot/azure/virtual-machines/serial-console-linux#custom-linux-images
*/
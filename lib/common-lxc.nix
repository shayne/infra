{
  imports = [ ../lib/reverse-proxy.nix ];

  # this might be OK to revert if the sleep
  # for acme is working
  services.resolved.enable = false;
  environment.etc."resolv.conf".text = ''
    nameserver 10.2.5.2
    search lan
  '';
}

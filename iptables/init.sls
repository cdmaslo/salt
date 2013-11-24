iptables:
  pkg.installed:
    - pkgs:
      - iptables
      - iptables-persistent
iptables:
  pkg.installed:
    - pkgs:
      - iptables
      - iptables-persistent

/etc/iptables/rules:
  file.managed:
    - source: salt://iptables/rules.jinja
    - template: jinja
    - context:
        accept_tcp_ports: {{ pillar.get('accept_tcp_ports', []) }}
        accept_tcp_from: {{ pillar.get('accept_tcp_from', []) }}
        limit_tcp_ports: {{ pillar.get('limit_tcp_ports', [22]) }}
    - require:
      - pkg: iptables

reload_rules:
  cmd.wait:
    - name: iptables-restore < /etc/iptables/rules
    - watch:
      - file: /etc/iptables/rules  
      - pkg: iptables
      - pkg: compare_running_iptables
      
compare_running_iptables:
  cmd.run:
    -name: 'cat /etc/iptables/rules | grep -E "^COMMIT$|^\*filter$|^#.*$|^$" --invert-match > /tmp/iptables.rules.orig ; iptables -S > /tmp/iptables.rules.active'
#  file.get_diff:
#    - minionfile:  /tmp/iptables.rules.active
#    - masterfile: file:/tmp/iptables.rules.orig

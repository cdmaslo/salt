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

/tmp/iptables_check.sh:
  file.managed:
    - source: salt://iptables/iptables_check.sh
    - mode: 755
  cmd.run:
    - name: /tmp/iptables_check.sh
    - cwd: /
    - stateful: True
 
reload_rules:
  cmd.wait:
    - name: iptables-restore < /etc/iptables/rules
    - watch:
      - file: /etc/iptables/rules  
      - pkg: iptables
      - file: /tmp/iptables_check.sh
      
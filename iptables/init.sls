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

compare_running_iptables:
  file.diff:
        
    - require:
      - file: /etc/iptables/rules
      - pkg: iptables

  cmd.wait:
    - name: iptables-restore < /etc/iptables/rules
    - watch:
      - file: /etc/iptables/rules  
      - pkg: iptables
      

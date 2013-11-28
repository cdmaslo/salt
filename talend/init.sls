/tmp/salt/install/talend_latest.zip:
  file.managed:
    - source: salt://../install/talend_latest.zip
    - require:
      - pkg: oracle-java7-installer
      - pkg: unzip

/tmp/salt/talend_install.sh:
  file.managed:
    - source: salt://talend/talend_install.sh
    - mode: 755
  cmd.wait:
    - name: /tmp/salt/talend_install.sh
    - cwd: /
    - stateful: True
    - watch:
      - file: /tmp/salt/install/talend_latest.zip  
      
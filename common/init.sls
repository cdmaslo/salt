corepkgs:
  pkg.installed:
    - names:
      - wget
      - joe
      - lsof
      - unzip

unneededpkgs:
  pkg.purged:
    - names:
      - jfsutils

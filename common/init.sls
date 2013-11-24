corepkgs:
  pkg.installed:
    - names:
      - wget
      - joe
      - lsof

unneededpkgs:
  pkg.purged:
    - names:
      - jfsutils

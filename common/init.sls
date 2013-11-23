corepkgs:
  pkg.installed:
    - names:
      - wget
      - joe

unneededpkgs:
  pkg.purged:
    - names:
      - jfsutils

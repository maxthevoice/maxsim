{% set api = salt['pillar.get']('maxsim:api') %}

create {{ api.user }} user:
  user.present:
    - name: {{ api.user }}

maxsim-packages:
  pkg.installed:
    - names:
      - python-pip
      - python-virtualenv
      - python3.4-dev
      - python-dev
      - postgresql-server-dev-9.3
      - libxml2-dev
      - libxslt1-dev
      - libjpeg62-dev

{%- set api = salt['pillar.get']('maxsim:api') %}

include:
  - nginx

add ~ add user to virtualenvs:
  group.present:
    - name: virtualenvs
    - addusers:
      - {{api['user']}}

# Create the Python Virtual environment
{{ api['virtualenv'] }}:
  file.directory:
    - makedirs: True
    - group: virtualenvs
    - mode: 775
  virtualenv.managed:
    - system_site_packages: False
    - distribute: True
    - python: /usr/bin/python3.4
    - requirements: {{api['path']}}/requirements.txt
    - no_chown: True
    - require:
      - pkg: python-virtualenv
      - pkg: python3.4-dev
      - pkg: postgresql-server-dev-9.3
      - pkg: libxml2-dev
      - pkg: libxslt1-dev
      - pkg: libjpeg62-dev

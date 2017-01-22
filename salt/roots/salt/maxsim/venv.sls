include:
  - nginx

# Create the Python Virtual environment
{{ pillar['django']['virtualenv'] }}:
  virtualenv.managed:
    - system_site_packages: False
    - distribute: True
    - python: /usr/bin/python3.4
    - user: {{ pillar['django']['user'] }}
    - no_chown: True
    - require:
      - pkg: python-virtualenv
      - pkg: python3.4-dev
      - pkg: postgresql-server-dev-9.3
      - pkg: libxml2-dev
      - pkg: libxslt1-dev
      - pkg: libjpeg62-dev

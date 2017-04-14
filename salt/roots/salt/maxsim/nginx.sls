{% set maxsim = salt['pillar.get']('maxsim:maxsim') %}
{% set server_name = maxsim['nginx_server_name'] %}
{% set main_domain = server_name.split(' ')[0] %}
include:
  - nginx

maxsim-nginx-conf:
  file.managed:
    - name: /etc/nginx/sites-available/maxsim.conf
    - source: salt://maxsim/files/nginx.conf
    - template: jinja
    - user: www-data
    - group: www-data
    - mode: 755
    - context:
      maxsim: {{ maxsim }}
      server_name: {{ server_name }}
      main_domain: {{ main_domain }}
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

# Symlink and thus enable the virtual host
maxsim-enable-nginx:
  file.symlink:
    - name: /etc/nginx/sites-enabled/maxsim.conf
    - target: /etc/nginx/sites-available/maxsim.conf
    - force: false
    - require:
      - file: maxsim-nginx-conf

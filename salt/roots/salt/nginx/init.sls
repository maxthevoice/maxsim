include:
  - requirements.essential

nginx:
  pkg:
    - installed
  service.running:
    - enable: True
    - require:
      - pkg: nginx

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/files/nginx.conf
    - user: root
    - mode: 400
    - template: jinja
    - require:
      - pkg: nginx
    - watch_in:
      - service: nginx

www-data:
  user.present:
    - home: /var/www
    - require:
      - pkg: bash
      - pkg: nginx

/var/www:
  file.directory:
    - user: www-data
    - group: www-data
    - require:
      - user: www-data
      - pkg: nginx

/etc/nginx/sites-available:
  file.directory:
    - user: root
    - mode: 755
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled:
  file.directory:
    - user: root
    - mode: 755
    - require:
      - pkg: nginx

# We don't need 4096 dhparam size on vagrant, takes a while to generate ;)
openssl dhparam -out {{ salt['pillar.get']('nginx:dhparam_path', '/etc/nginx/dhparams.pem') }} {{ salt['pillar.get']('nginx:dhparam_bits', 4096) }}:
  cmd.run:
    - unless: ls {{ salt['pillar.get']('nginx:dhparam_path', '/etc/nginx/dhparams.pem') }}

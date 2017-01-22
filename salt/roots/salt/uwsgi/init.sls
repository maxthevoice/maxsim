uwsgi-packages:
  pkg.installed:
    - names:
      - python-pip
      - python-dev

uwsgi:
  pip.installed:
    - require:
      - pkg: python-pip
      - pkg: python-dev

/etc/uwsgi/apps-available:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: true
    - require:
      - pip: uwsgi
      - pkg: nginx

/etc/uwsgi/apps-enabled:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: true
    - require:
      - pip: uwsgi
      - pkg: nginx

/etc/init/uwsgi.conf:
  file.managed:
    - source: salt://uwsgi/uwsgi.conf
    - template: jinja
    - require:
      - pip: uwsgi

uwsgi-service:
  service.running:
    - enable: True
    - name: uwsgi
    - watch:
      - file: /etc/uwsgi/apps-enabled/*
    - require:
      - file: /etc/init/uwsgi.conf

/var/log/uwsgi:
  file.directory:
    - user: www-data
    - group: www-data
    - makedirs: true
    - require:
      - pip: uwsgi
      - pkg: nginx

/var/log/uwsgi/emperor.log:
  file.managed:
    - user: www-data
    - group: www-data
    - require:
      - pip: uwsgi
      - pkg: nginx

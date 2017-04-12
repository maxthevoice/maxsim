supervisor:
  pkg:
    - installed
  service.running:
    - require:
      - file: /etc/init.d/supervisor
      - file: /etc/supervisor/supervisord.conf
      - file: /var/log/supervisor/supervisord.log

# init script
/etc/init.d/supervisor:
  file.managed:
    - source: salt://supervisor/files/supervisor
    - require:
      - pkg: supervisor

/var/log/supervisor/supervisord.log:
  file.managed:
    - makedirs: true

/etc/supervisor/supervisord.conf:
  file.managed:
    - template: jinja
    - source: salt://supervisor/files/supervisord.conf
    - require:
      - pkg: supervisor
    - watch_in:
      - service: supervisor

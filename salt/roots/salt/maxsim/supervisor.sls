{%- set api = salt['pillar.get']('maxsim:api') %}

include:
  - supervisor

# gunicorn script
maxsim gunicorn script:
  file.managed:
    - name: /srv/gunicorn-maxsim.sh
    - source: salt://maxsim/files/gunicorn.sh
    - template: jinja
    - mode: 0744
    - user: {{ api.user }}
    - group: {{ api.group }}
    - context:
        address: 127.0.0.1:{{ api.gunicorn_port }} # internal port, reverse proxied by nginx
        project_name: maxsim
        document_root: {{ api.path }}
        user: {{ api.user }}
        group: {{ api.group }}
        django_settings_module: {{ api.settings }}
        gunicorn_path: {{ api.virtualenv }}/bin/gunicorn
        reload: {{ grains['virtual'] }} # Auto reload from source if on virtualbox
        timeout: {{ api['timeout'] | default(300) }}
        workers: {{ api['workers'] | default(2) }}


# main application workers
maxsim supervisor:
  file.managed:
    - name: /etc/supervisor/conf.d/maxsim.conf
    - source: salt://maxsim/files/supervisor/maxsim.conf
    - template: jinja
    - context:
        command: /srv/gunicorn-maxsim.sh
        user: {{ api.user }}
        directory: {{ api.path }}
    - require:
      - file: /srv/gunicorn-maxsim.sh
    - require_in:
      - service: supervisor
  supervisord.running:
    - name: maxsim
    - restart: True


# This way, supervisor jobs are updated directly
reload and update supervisor:
  cmd.run:
    - name: supervisorctl reread && supervisorctl update
    - require:
      - service: supervisor
      - file: /etc/supervisor/conf.d/maxsim.conf

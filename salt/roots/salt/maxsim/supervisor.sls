{%- set maxsim = salt['pillar.get']('maxsim:maxsim') %}

include:
  - supervisor

# gunicorn script
maxsim gunicorn script:
  file.managed:
    - name: /etc/gunicorn-maxsim.sh
    - source: salt://maxsim/files/gunicorn.sh
    - template: jinja
    - mode: 0744
    - user: {{ maxsim.user }}
    - group: {{ maxsim.group }}
    - context:
        address: 127.0.0.1:{{ maxsim.gunicorn_port }} # internal port, reverse proxied by nginx
        project_name: maxsim
        document_root: {{ maxsim.path }}
        user: {{ maxsim.user }}
        group: {{ maxsim.group }}
        django_settings_module: {{ maxsim.settings }}
        gunicorn_path: {{ maxsim.virtualenv }}/bin/gunicorn
        reload: {{ grains['virtual'] }} # Auto reload from source if on virtualbox
        timeout: {{ maxsim['timeout'] | default(300) }}
        workers: {{ maxsim['workers'] | default(2) }}


# main application workers
maxsim supervisor:
  file.managed:
    - name: /etc/supervisor/conf.d/maxsim.conf
    - source: salt://maxsim/files/supervisor/maxsim.conf
    - template: jinja
    - context:
        command: /etc/gunicorn-maxsim.sh
        user: {{ maxsim.user }}
        directory: {{ maxsim.path }}
    - require:
      - file: /etc/gunicorn-maxsim.sh
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

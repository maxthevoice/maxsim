{%- import 'maxsim/macros.jinja' as m %}
{%- set maxsim = salt['pillar.get']('maxsim:maxsim') %}

include:
  - .requirements
  - .nginx
  - .venv
  - .dotenv
  - .postgresql
  - .supervisor
  - maxsim.share

maxsim ~ migrate:
  cmd.run:
    - name: {{ m.in_venv_with_dotenv('python manage.py migrate --noinput --no-color') }}
    - cwd: {{ maxsim.path }}
    - require:
      - virtualenv: {{maxsim['virtualenv']}}

maxsim ~ collectstatic:
  cmd.run:
    - name: {{ m.in_venv_with_dotenv('python manage.py collectstatic --noinput --no-color') }}
    - cwd: {{ maxsim.path }}
    - require:
      - virtualenv: {{maxsim['virtualenv']}}

{% for user in salt['pillar.get']('maxsim:maxsim:superusers') %}
# from http://stackoverflow.com/questions/6244382/how-to-automate-createsuperuser-on-django
maxsim ~ create superuser ({{user['username']}}):
  {% set add_user_cmd = "python manage.py runscript create_or_update_superuser --script-args %s %s %s " % (user.username, user.email, user.password) %}
  cmd.run:
    - name: {{ m.in_venv_with_dotenv(add_user_cmd) }}
    - cwd: {{ maxsim['path'] }}
{% endfor %}

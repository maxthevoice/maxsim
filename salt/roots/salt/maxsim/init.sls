{%- import 'maxsim/macros.jinja' as m %}
{%- set api = salt['pillar.get']('maxsim:api') %}

include:
  - .requirements
  - .nginx
  - .venv
  - .dotenv
  - .postgresql
  - .supervisor
  - maxsim.share

api ~ migrate:
  cmd.run:
    - name: {{ m.in_venv_with_dotenv('python manage.py migrate --noinput --no-color') }}
    - cwd: {{ api.path }}
    - require:
      - virtualenv: {{api['virtualenv']}}

api ~ collectstatic:
  cmd.run:
    - name: {{ m.in_venv_with_dotenv('python manage.py collectstatic --noinput --no-color') }}
    - cwd: {{ api.path }}
    - require:
      - virtualenv: {{api['virtualenv']}}

{% for user in salt['pillar.get']('maxsim:api:superusers') %}
# from http://stackoverflow.com/questions/6244382/how-to-automate-createsuperuser-on-django
api ~ create superuser ({{user['username']}}):
  {% set add_user_cmd = "python manage.py runscript create_or_update_superuser --script-args %s %s %s " % (user.username, user.email, user.password) %}
  cmd.run:
    - name: {{ m.in_venv_with_dotenv(add_user_cmd) }}
    - cwd: {{ api['path'] }}
{% endfor %}

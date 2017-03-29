{% set api = salt['pillar.get']('maxsim:api') %}
{% set postgresql = salt['pillar.get']('maxsim:postgresql') %}

{% set env_variables = {
  "MAXSIM_DEBUG": true,
  "MAXSIM_DB_ENGINE": api.db_engine | default('django.db.backends.postgresql_psycopg2'),
  "MAXSIM_DB_PORT": api.db_port | default("'5555'"),
  "MAXSIM_DB_NAME": postgresql.db | default("maxsim"),
  "MAXSIM_DB_USER": postgresql.user | default('maxsim'),
  "MAXSIM_DB_PASSWORD": postgresql.password | default('maxsim'),
  "MAXSIM_DB_HOST": postgresql.host | default('localhost'),
} %}

maxsim-dotenv:
  file.managed:
    - source: salt://.env.jinja
    - name: {{ api.path }}/.env
    - template: jinja
    - context:
      env_variables: {{ env_variables }}

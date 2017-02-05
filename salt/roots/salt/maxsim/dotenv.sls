{% set django = pillar['django'] %}
{% set postgresql = pillar['postgresql'] %}

{% set env_variables = {
  "MAXSIM_DEBUG": true,
  "MAXSIM_DB_ENGINE": django.db_engine | default('django.db.backends.postgresql_psycopg2'),
  "MAXSIM_DB_PORT": django.db_port | default("'5555'"),
  "MAXSIM_DB_NAME": postgresql.db | default("maxsim"),
  "MAXSIM_DB_USER": postgresql.user | default('maxsim'),
  "MAXSIM_DB_PASSWORD": postgresql.password | default('maxsim'),
  "MAXSIM_DB_HOST": postgresql.host | default('localhost'),
} %}

example-dotenv:
  file.managed:
    - source: salt://.env.jinja
    - name: {{ django.path }}/.env
    - template: jinja
    - context:
      env_variables: {{ env_variables }}

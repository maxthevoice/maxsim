{% set maxsim = salt['pillar.get']('maxsim:maxsim') %}
{% set postgresql = salt['pillar.get']('maxsim:postgresql') %}

{% set env_variables = {
  "MAXSIM_DEBUG": true,
  "MAXSIM_ALLOWED_HOSTS": maxsim.allowed_hosts | default('[*]'),
  "MAXSIM_DB_ENGINE": maxsim.db_engine | default('django.db.backends.postgresql_psycopg2'),
  "MAXSIM_DB_PORT": maxsim.db_port | default('5432'),
  "MAXSIM_DB_NAME": postgresql.db | default('maxsim'),
  "MAXSIM_DB_USER": postgresql.user | default('maxsim'),
  "MAXSIM_DB_PASSWORD": postgresql.password | default('maxsim'),
  "MAXSIM_DB_HOST": postgresql.host | default('localhost'),
} %}

maxsim-dotenv:
  file.managed:
    - source: salt://.env.jinja
    - name: {{ maxsim.path }}/.env
    - template: jinja
    - context:
      env_variables: {{ env_variables }}

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

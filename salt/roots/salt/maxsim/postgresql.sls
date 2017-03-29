{%- set postgresql = salt['pillar.get']('maxsim:postgresql') %}

include:
  - postgresql

maxsim-postgres-user:
  postgres_user.present:
    - name: {{ postgresql.user }}
    - createdb: {{ postgresql.createdb }}
    - password: {{ postgresql.password }}
    - runas: postgres
    - require:
      - service: postgresql

maxsim-postgres-db:
  postgres_database.present:
    - name: {{ postgresql.db }}
    - encoding: UTF8
    - lc_ctype: en_US.UTF8
    - lc_collate: en_US.UTF8
    - template: template0
    - owner: {{ postgresql.user }}
    - runas: postgres
    - require:
        - postgres_user: maxsim-postgres-user

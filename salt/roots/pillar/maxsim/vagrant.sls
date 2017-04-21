maxsim:
  maxsim:
    nginx_server_name: maxsimhockey.example.com *.ngrok.io *.localtunnel.me
    allowed_hosts: ['*.example.com']
    debug: true
    user: vagrant
    group: vagrant
    db_engine: django.db.backends.postgresql_psycopg2
    db_port: 5432
    superusers:
      - username: vagrant
        email: maxime.lavoie2@gmail.com
        password: vagrant

  postgresql:
    db: maxsim
    user: maxsim
    password: maxsim
    createdb: True

nginx:
  dhparam_bits: 128

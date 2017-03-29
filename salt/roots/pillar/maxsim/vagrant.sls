maxsim:
  api:
    nginx_server_name: localhost
    debug: true
    user: vagrant
    group: vagrant
    settings: maxsim.settings
    superusers:
      - username: vagrant
        email: vagrant@localhost
        password: vagrant

  postgresql:
    db: maxsim
    user: maxsim
    password: maxsim
    createdb: True

nginx:
  dhparam_bits: 128

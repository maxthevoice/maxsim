maxsim:
  api:
    nginx_server_name: hockey.maxsim.vagrant *.ngrok.io *.localtunnel.me
    allowed_hosts: ['*.maxsim.vagrant']
    debug: true
    user: vagrant
    group: vagrant
    settings: maxsim.settings
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

# Maxsim Django Salted vagrant

Uses [SaltStack] to provision a [django] application initally started from [django-salted]

## Tools needed

- [Virtualbox]
- [Virtualbox extensions]
- [Vagrant]

## Getting started

[Documentation on repository's wiki]

[SaltStack]: http://saltstack.com/community.html
[Virtualbox]: https://www.virtualbox.org/
[Virtualbox extensions]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: http://www.vagrantup.com/
[django]: https://docs.djangoproject.com
[django-salted]: https://github.com/wunki/django-salted/
[Documentation on repository's wiki]: https://github.com/WEGOTRADE/vagrant/wiki

## Prerequisis

pip install -r /vagrant/maxsim/requirements.txt

## validation

python -m django --version

## usefull commands

vagrant up
vagrant ssh
source env/bin/activate
sudo salt-call state.highstate
pip freeze > requirements.txt

## When internal servor error or 502 bad gateway
sudo service uwsgi restart

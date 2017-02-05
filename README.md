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

## First steps

- vagrant up
- vagrant ssh

## Create alias
- vim ~/.bash_aliases
- alias api='source /home/vagrant/env/bin/activate;cd /vagrant/maxsim/'
- source ~/.bashrc

Now execute the command `api`, easy!

## Validate the version

- python -V
- python -m django --version

## Prerequisis

- pip install -r /vagrant/maxsim/requirements.txt
- python manage.py migrate

## usefull commands

- sudo salt-call state.highstate
- pip freeze > /vagrant/maxsim/requirements.txt

## When internal servor error or 502 bad gateway(Doesn't work yet, waiting for Gunicorn/Supervisor)

- sudo service uwsgi restart

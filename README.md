# Maxsim Django Salted vagrant

Uses [SaltStack] to provision a [django] application initally started from [django-salted]

## Tools needed

- [Virtualbox]
- [Virtualbox extensions]
- [Vagrant]

## Getting started

[SaltStack]: http://saltstack.com/community.html
[Virtualbox]: https://www.virtualbox.org/
[Virtualbox extensions]: https://www.virtualbox.org/wiki/Downloads
[Vagrant]: http://www.vagrantup.com/
[django]: https://docs.djangoproject.com
[django-salted]: https://github.com/wunki/django-salted/

## First steps

- vagrant up
- vagrant ssh

## Create alias
- vim ~/.bash_aliases
- alias maxsim='source /usr/local/virtualenvs/maxsim/bin/activate;cd /srv/maxsim/'
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

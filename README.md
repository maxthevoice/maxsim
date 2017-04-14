# Maxsim

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
[django REST framework]: http://www.django-rest-framework.org/
[django-salted]: https://github.com/wunki/django-salted/

## First steps

- vagrant up
- vagrant ssh

## Create alias

- vim ~/.bash_aliases
- alias maxsim='source /usr/local/virtualenvs/maxsim/bin/activate;cd /srv/maxsim/'
- source ~/.bashrc

Now execute the command `maxsim`, easy!

## usefull commands

- pip install -r /srv/maxsim/requirements.txt
- pip freeze > /srv/maxsim/requirements.txt
- sudo salt-call state.highstate
- sudo chown -R vagrant:vagrant /usr/local/virtualenvs/maxsim/

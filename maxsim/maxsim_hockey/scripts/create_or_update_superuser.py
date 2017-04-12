from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist


def run(*args):
    """
    usage:
    python manage.py runscript create_or_update_super_user --script-args=<username> <email> <password>

    http://django-extensions.readthedocs.org/en/latest/runscript.html

    This script is a wrapper over django's create_superuser
    @see django.contrib.auth.models.UserManager#create_superuser
    """
    username = args[0]
    email = args[1]
    password = args[2]

    try:
        user = User.objects.get(username=username)
        print("Found user `%s`, updating email and password" % username)
        user.email = email
        user.set_password(password)
        user.save()
    except ObjectDoesNotExist:
        print("User `%s` was not found, creating new user" % username)
        User.objects.create_superuser(username, email, password)

    print("Success!")

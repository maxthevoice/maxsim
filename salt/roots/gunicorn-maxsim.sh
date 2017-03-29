#!/bin/bash
# This script should be run by supervisor to make sure gunicorn is always up.

set -e

NUM_WORKERS=2
TIMEOUT=300
ADDRESS=127.0.0.1:3000

# django application's wsgi module path
WSGI_APPLICATION=maxsim.wsgi:application

# Project's directory to run from
PYTHON_PATH=/vagrant/maxsim/

# user/group to run as
USER=vagrant
GROUP=vagrant

# Log stuff
ACCESS_LOGFILE=/vagrant/maxsim/logs/maxsim-access.log
ERROR_LOGFILE=/vagrant/maxsim/logs/maxsim-error.log
LOGFILE=/vagrant/maxsim/logs/maxsim-worker.log
LOGDIR=$(dirname $LOGFILE)
# debug
# info
# warning
# error
# critical
LOG_LEVEL=info
# switch to project dir to find wsgi_application
cd ${PYTHON_PATH}

test -d ${LOGDIR} || mkdir -p ${LOGDIR}

export DJANGO_SETTINGS_MODULE="maxsim.settings"

# load local environment (or fail silently)
export $(cat /vagrant/maxsim/.env | xargs) || true

# executes gunicorn with given parameters
exec /home/vagrant/env/bin/gunicorn --reload \
  --user=${USER} \
  --group=${GROUP} \
  --log-level=${LOG_LEVEL} \
  --bind=${ADDRESS} \
  --workers ${NUM_WORKERS} \
  --timeout ${TIMEOUT} \
  --pythonpath ${PYTHON_PATH} \
  --log-file=${LOGFILE} 2>>${LOGFILE} \
  --error-logfile ${ERROR_LOGFILE} \
  --access-logfile ${ACCESS_LOGFILE} \
  ${WSGI_APPLICATION}

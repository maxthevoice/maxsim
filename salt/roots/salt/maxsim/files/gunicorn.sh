#!/bin/bash
# This script should be run by supervisor to make sure gunicorn is always up.

set -e

NUM_WORKERS={{ workers }}
TIMEOUT={{ timeout }}
ADDRESS={{ address }}

# django application's wsgi module path
WSGI_APPLICATION={{ project_name }}.wsgi:application

# Project's directory to run from
PYTHON_PATH={{ document_root }}/

# user/group to run as
USER={{ user }}
GROUP={{ group }}

# Log stuff
ACCESS_LOGFILE={{ document_root }}/logs/{{ project_name }}-access.log
ERROR_LOGFILE={{ document_root }}/logs/{{ project_name }}-error.log
LOGFILE={{ document_root }}/logs/{{ project_name }}-worker.log
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

export DJANGO_SETTINGS_MODULE="{{ django_settings_module }}"

# load local environment (or fail silently)
export $(cat {{ document_root }}/.env | xargs) || true

# executes gunicorn with given parameters
exec {{ gunicorn_path }}{% if reload | default(False) %} --reload{% endif %} \
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

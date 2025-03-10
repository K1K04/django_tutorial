#!/bin/bash
cd /usr/share/app/
export DJANGO_SUPERUSER_PASSWORD=$DJ_PASSWORD
sleep 20
python3 manage.py migrate
python manage.py createsuperuser --username=$DJ_USER --email=$DJ_EMAIL --noinput
python3 manage.py runserver 0.0.0.0:3000

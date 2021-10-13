#!/bin/bash

dnf install -y postgresql-server postgresql postgresql-devel python3-pip python-devel postgresql-contrib libpq-devel gcc

sudo postgresql-setup --initdb --unit postgresql >> /tmp/postgres.setup.log

sudo /usr/bin/cp postgresql/postgresql.conf /var/lib/pgsql/data/
sudo /usr/bin/cp postgresql/pg_hba.conf /var/lib/pgsql/data/

sudo systemctl enable posrgresql --now

sudo pip install psycopg2

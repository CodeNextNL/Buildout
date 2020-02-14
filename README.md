# CodeNext Buildout
## Installation
* Create a virtualenv without setuptools:
`virtualenv -p python3 env`
* Run the bootstrap.py script: `./env/bin/python3 bootstrap.py`
* Create local.cfg with the following content:
```
[buildout]
extends = buildout.cfg

[odoo]
options.admin_passwd = your_admin_passwd
options.data_dir = your_data_dir
options.db_name = your_db_name
options.db_user = your_db_user
options.dbfilter = ^your_db_name$
options.logfile = your_log_file/path
```
* Activate virtualenv with `source env/bin/activate`
* Install requirements `env/bin/pip3 install -r requirements.txt`
* Run `bin/buildout -c local.cfg`

In case an ImportError with psycopg2 occurs: `env/bin/pip3 install psycopg2`. (StackOverflow: https://stackoverflow.com/questions/48780354/python-django-error-version-glibc-private-not-defined)

## Run
* Activate virtualenv with `source env/bin/activate`
* Run `bin/start_odoo` to start Odoo 
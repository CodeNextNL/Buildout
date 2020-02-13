# CodeNext Buildout
## Installation
* Create a virtualenv without setuptools:
`virtualenv -p python3 env --no-setuptools`
* Run the bootstrap.py script: `sandbox/bin/python3 bootstrap.py`
* Create local.cfg with the following content:
```
[buildout]
extends = buildout.cfg

[odoo]
options.db_name = your_db_name
options.dbfilter = ^your_db_name$
options.admin_passwd = your_admin_passwd
```
* Run `bin/buildout -c local.cfg`

## Run
* Run `bin/start_odoo` to start Odoo 
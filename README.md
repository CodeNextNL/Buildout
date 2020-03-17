# CodeNext Odoo

## Installation

- Clone this repository.
- Change variables in install.sh
- Make install.sh executable: `sudo chmod +x install.sh`
- Run install.sh: `./install.sh`
- Change Odoo configartion in \*-venv/odoo.conf:

```
[options]
admin_passwd = your_admin_password
dbfilter = ^your_dbfilter$
db_name = your_db_name
db_user = your_db_user (e.g. odoo)
http_port = your_http_port (e.g. 8069)
longpolling_port = your_longpolling_port (e.g. 8072)
addons_path = /usr/lib/python3/dist-packages/odoo/addons
```

## Run

- Run in odoo home folder `./odoo11-venv/bin/python3 odoo11/odoo-bin -c odoo11-venv/odoo11.conf` to start Odoo

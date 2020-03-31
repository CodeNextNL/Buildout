#/bin/bash

# VARIABLES
odoouser=odoo
odoohome=/home/$odoouser
odooinstancehome=$odoohome/odoo11
venv=odoo11-venv
odoo=https://www.github.com/odoo
oca=https://github.com/OCA
codenext=https://github.com/CodeNextNL
branch=11.0

# ODOO
## check if Odoo is already installed
if [ ! -d $odooinstancehome ]; then
  git clone $odoo/odoo --depth 1 --branch $branch $odooinstancehome
fi

## check if venv is created
if [ ! -d $odoohome/$venv ]; then
  cd $odoohome
  virtualenv -p python3 $venv
  source $venv/bin/activate
  pip3 install -r $odooinstancehome/requirements.txt
  deactivate
fi

# CUSTOM ADDONS

if [ ! -d $odoohome/odoo11-custom-addons ]; then
  sudo -u $odoouser mkdir -p $odoohome/odoo11-custom-addons
  sudo -u $odoouser chown $odoouser: $odoohome/odoo11-custom-addons
fi

# create directories
cd $odoohome/odoo11-custom-addons
mkdir -p oca
mkdir -p codenext
mkdir -p misc

# clone repositories (repos["httpgit"]=folder | key, value)

declare -A repos
repos["$oca/partner-contact"]=oca/partner-contact
repos["$oca/web"]=oca/web
repos["$oca/server-brand"]=oca/server-brand
repos["$oca/server-tools"]=oca/server-tools
repos["$oca/website"]=oca/website
repos["$oca/website-themes"]=oca/website-themes
repos["$oca/bank-statement-import"]=oca/bank-statement-import
repos["$oca/account-reconcile"]=oca/account-reconcile
repos["$oca/account-financial-reporting"]=oca/account-financial-reporting
repos["$oca/l10n-netherlands"]=oca/l10n-netherlands
repos["$oca/server-ux"]=oca/server-ux
repos["$oca/account-financial-tools"]=oca/account-financial-tools
repos["$codenext/codenext-custom"]=codenext/codenext-custom
repos["https://github.com/Yenthe666/auto_backup"]=misc/auto_backup

for repo in ${!repos[@]}; do
  cd $odoohome/odoo11-custom-addons
  if [ ! -d "${repos[${repo}]}" ]
  then
      git clone ${repo}.git --branch $branch ${repos[${repo}]}
  else
      cd ${repos[${repo}]}
      git pull
  fi
done

# install requirements.txt in custom addons
cd $odoohome
source $venv/bin/activate
for f in $odoohome/odoo11-custom-addons/*/*/requirements.txt ; do
  pip3 install -r $f
done
deactivate

# generate addons_path
addons_path="$odooinstancehome/addons"
for d in $odoohome/odoo11-custom-addons/*/* ; do
    addons_path+=,"$d"
done
echo $addons_path
echo -e "\r"

# create Odoo configuration file
if [ -f $odoohome/$venv/odoo11.conf ] ; then
    rm $odoohome/$venv/odoo11.conf
fi
touch $odoohome/$venv/odoo11.conf
echo "[options]
admin_passwd = your_admin_password  
dbfilter = ^your_dbfilter11$
db_name = your_dbname
db_user = your_dbuser
http_port = 8069
longpolling_port = 8072
addons_path = $addons_path" >> $odoohome/$venv/odoo11.conf
mysql -uroot -Bse "SET GLOBAL innodb_fast_shutdown = 1;XA RECOVER;"

sudo service mariadb-server stop
sudo service zabbix-proxy stop

sudo apt-get remove "mariadb-*" -y

sudo apt remove galera-3 -y

sudo apt install wget -y

wget https://downloads.mariadb.com/MariaDB/mariadb_repo_setup

echo "b9e90cde27affc2a44f9fc60e302ccfcacf71f4ae02071f30d570e6048c28597 mariadb_repo_setup" | sha256sum -c -

chmod +x mariadb_repo_setup

sudo ./mariadb_repo_setup --mariadb-server-version="mariadb-10.5"

sudo apt update

sudo apt install mariadb-server-10.5 -y

sudo mariadb-upgrade --force

VERSION=$(mysql -uroot -Bse "SELECT VERSION();")
ISVERSION='10.5'
if [[ "$VERSION" == *"$ISVERSION"* ]]; then
  echo "MariaDB updated and running!"
fi
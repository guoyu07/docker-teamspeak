#!/bin/bash

# /**********************/
# /*                    */
# /*       CONFIG       */
# /*                    */
# /**********************/
SUPERVISORD_CONFIG='/etc/supervisor/conf.d/supervisord.conf'

MYSQL_HOST="${MYSQL_HOST:-}"
MYSQL_PORT="${MYSQL_PORT:-}"
MYSQL_USER="${MYSQL_USER:-}"
MYSQL_PASS="${MYSQL_PASS:-}"
MYSQL_DB="${MYSQL_DB:-}"

# check for license-key
if [ -f $TS_INJECTS/licensekey.dat ]; then
    ln -s $TS_INJECTS/licensekey.dat $TS_HOME/licensekey.dat
fi

# modify db settings
sed -i "s|host=.*|host=$MYSQL_HOST|g" $TS_HOME/ts3db_mariadb.ini
sed -i "s|port=.*|port=$MYSQL_PORT|g" $TS_HOME/ts3db_mariadb.ini
sed -i "s|username=.*|username=$MYSQL_USER|g" $TS_HOME/ts3db_mariadb.ini
sed -i "s|password=.*|password=$MYSQL_PASS|g" $TS_HOME/ts3db_mariadb.ini
sed -i "s|database=.*|database=$MYSQL_DB|g" $TS_HOME/ts3db_mariadb.ini
# adjust supervisord config
sed -i "s|{%TS_HOME%}|$TS_HOME|g; s|{%TS_USER%}|$TS_USER|g" $SUPERVISORD_CONFIG

chown -R $TS_USER. $TS_HOME $TS_INJECTS

# wait for the database to come up
while ! nc -z $MYSQL_HOST $MYSQL_PORT; do sleep 3; done
/usr/bin/supervisord -c $SUPERVISORD_CONFIG

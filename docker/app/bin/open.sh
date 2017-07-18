#!/usr/bin/env bash

until cd /var/www/public ; do
    echo "Wait for project folder mount"
done

touch /var/log/phalcon/log
chmod 666 /var/log/phalcon/log
echo "" > /var/www/.phalcon/migration-version
cd /var/www
phalcon migration run
mysqldump --host "$MYSQL_DATABASE_HOST" --no-data  --routines --triggers --databases $MYSQL_DATABASE -u $MYSQL_USER -p$MYSQL_PASSWORD > /var/www/tests/_data/dump_test.sql
cat /var/www/tests/_data/dump_test.sql /var/www/tests/_data/inserts.sql > /var/www/tests/_data/dump.sql

mysql -e 'show tables' --host "$MYSQL_DATABASE_HOST" -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE \
  | while read table;  \
     do mysql -e "truncate table $table" --host "$MYSQL_DATABASE_HOST" -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE; \
    done

mysql --host "$MYSQL_DATABASE_HOST" -u $MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < /var/www/tests/_data/inserts.sql

/usr/sbin/apache2ctl -D FOREGROUND
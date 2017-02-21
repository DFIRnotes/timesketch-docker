#!/bin/bash
set -e

SECRET=$(openssl rand -base64 32)
PORT=9200

sed -i -e "s#SECRET_KEY = u''#SECRET_KEY = u'${SECRET}'#" /etc/timesketch.conf
sed -i -e "s#ELASTIC_HOST = u'.*'#ELASTIC_HOST = u'${HOST}'#" /etc/timesketch.conf
sed -i -e "s#ELASTIC_PORT = .*#ELASTIC_PORT = ${PORT}#" /etc/timesketch.conf

echo "local   all             timesketch                              md5" >> /etc/postgresql/9.5/main/pg_hba.conf

service postgresql restart

sudo -u postgres createuser -d -P -R -S timesketch
sudo -u postgres createdb -O timesketch timesketch

tsctl runserver -h 0.0.0.0 -p 5000

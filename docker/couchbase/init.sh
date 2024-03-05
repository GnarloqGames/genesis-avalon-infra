#!/bin/bash

USERNAME=$AVALOND_COUCHBASE_USERNAME
PASSWORD=$AVALOND_COUCHBASE_PASSWORD
HOST=http://${AVALOND_COUCHBASE_URL}:8091

output=$(couchbase-cli server-list -c $HOST --username $USERNAME --password $PASSWORD)
initialized=$?
if [ "$initialized" -eq 0 ]
then
    echo $output
    exit 0
fi

set -o errexit

couchbase-cli cluster-init \
    --cluster $HOST \
    --cluster-name genesis-avalon \
    --cluster-username $USERNAME \
    --cluster-password $PASSWORD \
    --services "data,index,query,fts"

couchbase-cli bucket-create \
    --cluster $HOST \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --bucket-ramsize 1024 \
    --bucket-type couchbase

couchbase-cli collection-manage \
    --cluster $HOST \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-scope development

couchbase-cli collection-manage \
    --cluster $HOST \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-scope production

couchbase-cli collection-manage \
    --cluster $HOST \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-collection development.buildings \
    --max-ttl 0

couchbase-cli collection-manage \
    --cluster $HOST \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-collection production.buildings \
    --max-ttl 0

cbq -user $USERNAME -password $PASSWORD -engine $HOST \
    --script 'CREATE PRIMARY INDEX ON `default`:`genesis-avalon`.`development`.`buildings`'

cbq -user $USERNAME -password $PASSWORD -engine $HOST \
    --script 'CREATE PRIMARY INDEX ON `default`:`genesis-avalon`.`production`.`buildings`'
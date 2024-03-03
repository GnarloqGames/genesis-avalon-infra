#!/bin/bash
USERNAME=$1
PASSWORD=$2

couchbase-cli cluster-init \
    --cluster-name genesis-avalon \
    --cluster-username $USERNAME \
    --cluster-password $PASSWORD

couchbase-cli bucket-create \
    --cluster http://localhost:8091 \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --bucket-ramsize 1024 \
    --bucket-type couchbase

couchbase-cli collection-manage \
    --cluster http://localhost:8091 \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-scope development

couchbase-cli collection-manage \
    --cluster http://localhost:8091 \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-scope production

couchbase-cli collection-manage \
    --cluster http://localhost:8091 \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-collection development.buildings \
    --max-ttl 0

couchbase-cli collection-manage \
    --cluster http://localhost:8091 \
    --username $USERNAME \
    --password $PASSWORD \
    --bucket genesis-avalon \
    --create-collection production.buildings \
    --max-ttl 0
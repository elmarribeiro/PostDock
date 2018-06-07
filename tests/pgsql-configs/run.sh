#!/usr/bin/env bash

docker-compose up -d postgres_conf
set -e

docker-compose exec  postgres_conf wait_local_postgres

if [ "2" != `docker-compose exec postgres_conf gosu postgres bash -c 'cat $PGDATA/postgresql.conf' | grep "listen_addresses = '*'\|max_replication_slots = 55" | wc -l | tr -d ' '` ]; then
    exit 1
fi
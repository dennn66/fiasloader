#!/usr/bin/env bash

echo "++++++++++++++++++ HELLO, DB = $POSTGRES_DB"
echo "++++++++++++++++++ CREATING INDEXES FOR TABLE = AO"
psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/create_ao_index.sql







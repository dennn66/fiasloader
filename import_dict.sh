#!/usr/bin/env bash

echo "++++++++++++++++++ HELLO, DB = $POSTGRES_DB"

for TBL_TO_LOAD in SOCRBASE ESTSTAT STRSTAT OPERSTAT
do
  echo "++++++++++++++++++ LOADING TABLE = $TBL_TO_LOAD"
  pgdbf $PATH_TO_DBF_FILES/$TBL_TO_LOAD.DBF | iconv -f cp866 -t utf-8 | psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB
  psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/init_${TBL_TO_LOAD,,}.sql  
done






#!/usr/bin/env bash

echo "++++++++++++++++++ IMPORT DICT, DB = $POSTGRES_DB"
DICTS_TO_LOAD=${1:-"SOCRBASE ESTSTAT STRSTAT OPERSTAT"}

echo "++++++++++++++++++ LOADING DICTS = $DICTS_TO_LOAD"

for TBL_TO_LOAD in $DICTS_TO_LOAD
do
  echo "++++++++++++++++++ LOADING DICT = $TBL_TO_LOAD"
  pgdbf $PATH_TO_DBF_FILES/$TBL_TO_LOAD.DBF | iconv -f cp866 -t utf-8 | psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB
  if test -f ./$(dirname $0)/init_${TBL_TO_LOAD,,}.sql; then
    psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/init_${TBL_TO_LOAD,,}.sql  
  fi
done






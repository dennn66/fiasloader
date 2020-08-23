#!/usr/bin/env bash

echo "++++++++++++++++++ HELLO, DB = $POSTGRES_DB"

TBL_TO_LOAD=$1

echo "++++++++++++++++++ LOADING TABLE = $TBL_TO_LOAD"
echo "${TBL_TO_LOAD,,}"
$(echo 'SET search_path TO myschema,public;'; pgdbf $PATH_TO_DBF_FILES/OPERSTAT.DBF) | iconv -f cp866 -t utf-8| psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB


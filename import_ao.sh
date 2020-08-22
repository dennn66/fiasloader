#!/usr/bin/env bash

echo "++++++++++++++++++ HELLO, DB = $POSTGRES_DB"

TBL_TO_LOAD=$1

echo "++++++++++++++++++ LOADING TABLE = $TBL_TO_LOAD"

first_loop_flag=true

for FULLPATH in `find $PATH_TO_DBF_FILES/$TBL_TO_LOAD* -type f`
do
    FILE="${FULLPATH##*/}"
    TABLE="${FILE%.*}"

    pgdbf $FULLPATH | iconv -f cp866 -t utf-8 | psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB
    psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
    DROP TABLE IF EXISTS TMP_$TBL_TO_LOAD; 
    ALTER TABLE $TABLE RENAME TO TMP_$TBL_TO_LOAD;"
    
    echo "++++++++++++++++++ TEMP TABLE $TABLE LOADED"

    if [[ "$first_loop_flag" = true ]]; then
      psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "CREATE TABLE IF NOT EXISTS ${TBL_TO_LOAD}2  AS SELECT * FROM TMP_$TBL_TO_LOAD WHERE 0 = 1;"
      echo "++++++++++++++++++ TARGET TABLE $TBL_TO_LOAD CREATED"
      first_loop_flag=false
    fi
    psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/init_${TBL_TO_LOAD,,}.sql
    echo "++++++++++++++++++ INSERT $TABLE DATA INTO $TBL_TO_LOAD"

    if [[ "$TABLE" != "$TBL_TO_LOAD" ]]; then
        echo "++++++++++++++++++ DROP TABLE $TABLE"
        psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "INSERT INTO ${TBL_TO_LOAD}2 SELECT * FROM TMP_$TBL_TO_LOAD;"
        psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/clean_${TBL_TO_LOAD,,}.sql
        psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "INSERT INTO AO2 SELECT * FROM TMP_AO;"
        psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "DROP TABLE TMP_$TBL_TO_LOAD;"
    fi

done






#!/usr/bin/env bash

echo "++++++++++++++++++ HELLO, DB = $POSTGRES_DB"

TBL_TO_LOAD=$1
TMP_TABLE=TMP_$TBL_TO_LOAD
REGION_TO_LOAD=${2:-"06 99"}

echo "++++++++++++++++++ LOADING TABLE = $TBL_TO_LOAD"

first_loop_flag=true

for REGION in $REGION_TO_LOAD
do
    for FULLPATH in `find $PATH_TO_DBF_FILES/$TBL_TO_LOAD$REGION* -type f`
    do
        FILE="${FULLPATH##*/}"
        TABLE="${FILE%.*}"

        pgdbf $FULLPATH | iconv -f cp866 -t utf-8 | psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB
        psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
            DROP TABLE IF EXISTS TMP_$TBL_TO_LOAD; 
            ALTER TABLE $TABLE RENAME TO $TMP_TABLE;"
        psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/init_${TBL_TO_LOAD,,}.sql   
        if [[ "$TBL_TO_LOAD" = "HOUSE" ]]; then
            echo "++++++++++++++++++ UPDATING REGION $REGION FOR $TABLE"
            psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
                UPDATE $TMP_TABLE SET regioncode = $REGION;"
        fi

        if [[ "$first_loop_flag" = true ]]; then
          psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "CREATE TABLE IF NOT EXISTS $TBL_TO_LOAD  AS SELECT * FROM TMP_$TBL_TO_LOAD WHERE 0 = 1;"
          echo "++++++++++++++++++ TARGET TABLE $TBL_TO_LOAD CREATED"
          first_loop_flag=false
        fi

        echo "++++++++++++++++++ INSERT $TABLE DATA INTO $TBL_TO_LOAD"

        if [[ "$TABLE" != "$TBL_TO_LOAD" ]]; then
            echo "++++++++++++++++++ DROP TABLE $TABLE"
            psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
                INSERT INTO $TBL_TO_LOAD SELECT * FROM TMP_$TBL_TO_LOAD;
                CREATE TABLE TMP_AO  AS SELECT * FROM public.AO WHERE 0 = 1;"
            psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/clean_${TBL_TO_LOAD,,}.sql
            psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
                INSERT INTO AO (guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, operstatus, divtype, startdate, updatedate, enddate) SELECT guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, operstatus, divtype, startdate, updatedate, enddate FROM TMP_AO ON CONFLICT (guid) DO UPDATE
                SET AO = excluded.AO;
                DROP TABLE TMP_$TBL_TO_LOAD;"
        fi
    done
done






#!/usr/bin/env bash

echo "++++++++++++++++++ IMPORT AO BY REGION, DB = $POSTGRES_DB"

TBL_TO_LOAD=$1
TMP_TABLE=TMP_$TBL_TO_LOAD
REGIONS_TO_LOAD=${2:-"1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 83 86 87 89 91 92 99"}

echo "++++++++++++++++++ LOADING TABLE = $TBL_TO_LOAD FOR REGIONS $REGIONS_TO_LOAD"

first_loop_flag=true

for REGION in $REGIONS_TO_LOAD
do
    for FULLPATH in `find $PATH_TO_DBF_FILES/$TBL_TO_LOAD$REGION* -type f`
    do
        FILE="${FULLPATH##*/}"
        TABLE="${FILE%.*}"

        pgdbf $FULLPATH | iconv -f cp866 -t utf-8 | psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB
        psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
            DROP TABLE IF EXISTS $TMP_TABLE; 
            ALTER TABLE $TABLE RENAME TO $TMP_TABLE;"
        if test -f ./$(dirname $0)/init_${TBL_TO_LOAD,,}.sql; then    
            psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/init_${TBL_TO_LOAD,,}.sql   
        fi
        if [[ "$TBL_TO_LOAD" = "HOUSE" ]]; then
            echo "++++++++++++++++++ UPDATING REGION $REGION FOR $TABLE"
            psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
                UPDATE $TMP_TABLE SET regioncode = $REGION;"
        fi
        if [[ "$first_loop_flag" = true ]]; then
          psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "CREATE TABLE IF NOT EXISTS $TBL_TO_LOAD  AS SELECT * FROM TMP_$TBL_TO_LOAD WHERE 0 = 1;
          ALTER TABLE $TMP_TABLE ADD PRIMARY KEY (id);"
          echo "++++++++++++++++++ TARGET TABLE $TBL_TO_LOAD CREATED"
          first_loop_flag=false
        fi

        echo "++++++++++++++++++ INSERT $TABLE DATA INTO $TBL_TO_LOAD"

        if [[ "$TABLE" != "$TBL_TO_LOAD" ]]; then
            echo "++++++++++++++++++ DROP TABLE $TABLE"
            psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
                INSERT INTO $TBL_TO_LOAD SELECT * FROM $TMP_TABLE ON CONFLICT (id) DO NOTHING;
                DROP TABLE IF EXISTS $TMP_TABLE;"
            if test -f ./$(dirname $0)/clean_${TBL_TO_LOAD,,}.sql; then
                psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
                DROP TABLE IF EXISTS TMP_AO;
                CREATE TABLE TMP_AO  AS SELECT * FROM public.AO WHERE 0 = 1;"
                psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -f ./$(dirname $0)/clean_${TBL_TO_LOAD,,}.sql
                psql postgresql://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB -c "
                    INSERT INTO AO SELECT * FROM TMP_AO ON CONFLICT (guid) DO UPDATE SET 
                    parentguid = excluded.parentguid, 
                    regioncode = excluded.regioncode, 
                    postalcode = excluded.postalcode, 
                    name = excluded.name, 
                    kod_t_st = excluded.kod_t_st, 
                    housenum = excluded.housenum, 
                    eststatus = excluded.eststatus, 
                    buildnum = excluded.buildnum, 
                    strucnum = excluded.strucnum, 
                    strstatus = excluded.strstatus, 
                    cadnum = excluded.cadnum, 
                    code = excluded.code, 
                    livestatus = excluded.livestatus, 
                    statstatus = excluded.statstatus, 
                    operstatus = excluded.operstatus, 
                    divtype = excluded.divtype, 
                    startdate = excluded.startdate, 
                    updatedate = excluded.updatedate, 
                    enddate = excluded.enddate;
                    DROP TABLE IF EXISTS TMP_AO;"
            fi
        fi
    done
done






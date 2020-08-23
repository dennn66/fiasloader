#!/usr/bin/env bash

echo "++++++++++++++++++ HELLO, DB = $POSTGRES_DB"

REGIONS_TO_LOAD=${1:-"06 99"}
TBLS_TO_LOAD=${2:-"ADDROB STEAD HOUSE"}


echo "++++++++++++++++++ LOADING TABLE = $TBL_TO_LOAD"

first_loop_flag=true

for TBL_TO_LOAD in $TBLS_TO_LOAD
do
    ./$(dirname $0)/import_ao_by_region.sh $TBL_TO_LOAD $REGIONS_TO_LOAD
done






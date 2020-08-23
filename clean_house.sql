INSERT INTO public.TMP_AO(
	guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, operstatus, divtype, startdate, updatedate, enddate) SELECT 
    guid, parentguid, regioncode, postalcode, null, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, null,       null, statstatus,       null, divtype, startdate, updatedate, enddate FROM  public.TMP_HOUSE;
    
CREATE  INDEX ao_guid_idx ON TMP_AO USING btree (guid);
    
DELETE FROM
    TMP_AO a
        USING TMP_AO b
WHERE
    a.enddate < b.enddate
    AND a.guid = b.guid;
    
DELETE FROM
    TMP_AO a
        USING TMP_AO b
WHERE
    a.updatedate < b.updatedate
    AND a.guid = b.guid;
    
DELETE FROM
    TMP_AO a
        USING TMP_AO b
WHERE
    a.startdate < b.startdate
    AND a.guid = b.guid;
    
DELETE FROM
    TMP_AO a
        USING TMP_AO b
WHERE
    a.ctid < b.ctid
    AND a.guid = b.guid;
    
UPDATE TMP_AO SET livestatus = 0;
  
UPDATE TMP_AO SET livestatus = 1 WHERE enddate = '2079-06-06';
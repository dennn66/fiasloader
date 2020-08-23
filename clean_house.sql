INSERT INTO public.TMP_AO(
	guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, operstatus, divtype, startdate, updatedate, enddate) SELECT 
    guid, parentguid, regioncode, postalcode, null,     null, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, null,       null, statstatus,       null, divtype, startdate, updatedate, enddate FROM  public.TMP_HOUSE;

DROP  INDEX IF EXISTS tmp_ao_guid_idx;    
CREATE  INDEX tmp_ao_guid_idx ON TMP_AO USING btree (guid);
    
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

-- strstatus | eststatus
UPDATE TMP_AO SET kod_t_st = eststat.kod_t_st FROM eststat WHERE eststat.eststatid = TMP_AO.eststatus;
UPDATE TMP_AO SET kod_t_st = strstat.kod_t_st FROM strstat WHERE strstat.strstatid = TMP_AO.strstatus and TMP_AO.eststatus=0;

UPDATE TMP_AO SET name = es.shortname || ' ' || h.housenum || ' ' || h.buildnum || ' ' || h.strucnum from TMP_AO AS h, strstat AS ss, eststat AS es 
WHERE h.eststatus = es.eststatid AND h.strstatus = ss.strstatid 
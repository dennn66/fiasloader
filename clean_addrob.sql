DROP TABLE IF EXISTS TMP_AO; 
CREATE TABLE TMP_AO  AS SELECT * FROM public.AO2 WHERE 0 = 1;
INSERT INTO public.TMP_AO(
	guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus,  operstatus, divtype, startdate, updatedate, enddate) SELECT 
    guid, parentguid, regioncode, postalcode, name, kod_t_st,     null,      null,     null,     null,      null, cadnum, code, livestatus,       null,  operstatus, divtype, startdate, updatedate, enddate FROM  public.TMP_ADDROB WHERE actstatus = 1;
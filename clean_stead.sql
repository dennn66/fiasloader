DROP TABLE IF EXISTS TMP_AO; 
CREATE TABLE TMP_AO  AS SELECT * FROM public.AO2 WHERE 0 = 1;
INSERT INTO public.ao(
	guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, currstatus, operstatus, divtype, startdate, updatedate, enddate) SELECT guid, parentguid, regioncode, postalcode, name, kod_t_st, null, null, null, null, null, cadnum, null, livestatus, statstatus, null, operstatus, divtype, startdate, updatedate, enddate FROM  public.stead WHERE actstatus = 1;
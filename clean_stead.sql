INSERT INTO public.TMP_AO(
	guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, operstatus, divtype, startdate, updatedate, enddate) SELECT 
    guid, parentguid, regioncode, postalcode, name, kod_t_st,     null,      null,     null,     null,      null, cadnum, null, livestatus, statstatus, operstatus, divtype, startdate, updatedate, enddate FROM  public.stead WHERE  nextid is null;;
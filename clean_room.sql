INSERT INTO public.TMP_AO(
	guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, operstatus, divtype, startdate, updatedate, enddate) SELECT 
    guid, parentguid, regioncode, postalcode, null,     null,     null,      null,     null,     null,      null, cadnum, null, livestatus,       null, operstatus,       0, startdate, updatedate, enddate FROM  public.TMP_ROOM WHERE  nextid is null;
    
--  flatnumber, flattype, roomnumber, roomtype,  roomcadnum
UPDATE TMP_AO SET kod_t_st = flattype.kod_t_st FROM flattype WHERE flattype.flattypeid = TMP_AO.flattype;
UPDATE TMP_AO SET kod_t_st = roomtype.kod_t_st FROM roomtype WHERE roomtype.roomtypeid = TMP_AO.roomtype and TMP_AO.flattype=0;

UPDATE TMP_AO SET name = ft.shortname || ' ' || r.flatnumber|| ' ' || r.roomnumber from TMP_AO AS r, roomtype AS rt, flattype AS ft 
WHERE r.flattype::int = ft.fltypeid AND r.roomtype::int = rt.rmtypeid 
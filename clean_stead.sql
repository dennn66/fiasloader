DROP TABLE IF EXISTS TMP_AO; 
CREATE TABLE public.TMP_AO
(

    guid uuid,
    parentguid uuid,
    regioncode character varying(2) COLLATE pg_catalog."default",
    postalcode character varying(6) COLLATE pg_catalog."default",
    name character varying(120) COLLATE pg_catalog."default",
    kod_t_st integer,

    housenum character varying(20) COLLATE pg_catalog."default",
    eststatus integer,
    buildnum character varying(50) COLLATE pg_catalog."default",
    strucnum character varying(50) COLLATE pg_catalog."default",
    strstatus integer,


    cadnum character varying(100) COLLATE pg_catalog."default",
    code character varying(17) COLLATE pg_catalog."default",

    livestatus integer,
    statstatus integer,
    currstatus integer,
    operstatus integer,
    divtype integer,
    
    startdate date,
    updatedate date,
    enddate date

)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
INSERT INTO public.ao(
	guid, parentguid, regioncode, postalcode, name, kod_t_st, housenum, eststatus, buildnum, strucnum, strstatus, cadnum, code, livestatus, statstatus, currstatus, operstatus, divtype, startdate, updatedate, enddate) SELECT guid, parentguid, regioncode, postalcode, name, kod_t_st, null, null, null, null, null, cadnum, null, livestatus, statstatus, null, operstatus, divtype, startdate, updatedate, enddate FROM  public.stead WHERE actstatus = 1;
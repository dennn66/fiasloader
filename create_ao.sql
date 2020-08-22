CREATE TABLE public.ao2
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
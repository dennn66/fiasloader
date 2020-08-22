ALTER TABLE TMP_ADDROBJ
DROP COLUMN  areacode,
DROP COLUMN  autocode,
DROP COLUMN  citycode ,
DROP COLUMN  centstatus,
DROP COLUMN  ifnsfl,
DROP COLUMN  ifnsul   ,
DROP COLUMN  okato   ,
DROP COLUMN  oktmo    ,
DROP COLUMN  placecode,
DROP COLUMN  plaincode   ,
DROP COLUMN  streetcode,
DROP COLUMN  terrifnsfl ,
DROP COLUMN  terrifnsul ,
DROP COLUMN  ctarcode ,
DROP COLUMN  extrcode,
DROP COLUMN  sextcode,
DROP COLUMN  plancode,
ADD COLUMN kod_t_st INTEGER ;

ALTER TABLE TMP_ADDROBJ RENAME COLUMN  formalname TO name;
ALTER TABLE TMP_ADDROBJ RENAME COLUMN  aoguid TO guid;
ALTER TABLE TMP_ADDROBJ RENAME COLUMN  aoid TO id;
ALTER TABLE TMP_ADDROBJ RENAME COLUMN  aolevel TO level;


-- update empty values for TMP_ADDROBJ .nextid
UPDATE TMP_ADDROBJ  SET nextid = NULL WHERE nextid = '';

--- update empty values for TMP_ADDROBJ .previd
UPDATE TMP_ADDROBJ  SET previd = NULL WHERE previd = '';

--- update empty values for TMP_ADDROBJ .parentguid
UPDATE TMP_ADDROBJ  SET parentguid = NULL WHERE parentguid = '';

--- update empty values for TMP_ADDROBJ .enddate
--- UPDATE TMP_ADDROBJ  SET enddate = NULL WHERE enddate = '';

--- update empty values for TMP_ADDROBJ .startdate
--- UPDATE TMP_ADDROBJ  SET startdate = NULL WHERE startdate = '';

--- update empty values for TMP_ADDROBJ .postalcode
UPDATE TMP_ADDROBJ  SET postalcode = NULL WHERE postalcode = '';

-- cast column TMP_ADDROBJ .guid to uuid

    alter table TMP_ADDROBJ  rename column guid to aoguid_x;
    alter table TMP_ADDROBJ  add column guid uuid;
    update TMP_ADDROBJ  set guid = aoguid_x::uuid;
    alter table TMP_ADDROBJ  drop column aoguid_x;


-- cast column TMP_ADDROBJ .id to uuid

    alter table TMP_ADDROBJ  rename column id to aoid_x;
    alter table TMP_ADDROBJ  add column id uuid;
    update TMP_ADDROBJ  set id = aoid_x::uuid;
    alter table TMP_ADDROBJ  drop column aoid_x;


-- cast column TMP_ADDROBJ .parentguid to uuid

    alter table TMP_ADDROBJ  rename column parentguid to parentguid_x;
    alter table TMP_ADDROBJ  add column parentguid uuid;
    update TMP_ADDROBJ  set parentguid = parentguid_x::uuid;
    alter table TMP_ADDROBJ  drop column parentguid_x;


-- cast column TMP_ADDROBJ .previd to uuid

    alter table TMP_ADDROBJ  rename column previd to previd_x;
    alter table TMP_ADDROBJ  add column previd uuid;
    update TMP_ADDROBJ  set previd = previd_x::uuid;
    alter table TMP_ADDROBJ  drop column previd_x;


-- cast column TMP_ADDROBJ .nextid to uuid

    alter table TMP_ADDROBJ  rename column nextid to nextid_x;
    alter table TMP_ADDROBJ  add column nextid uuid;
    update TMP_ADDROBJ  set nextid = nextid_x::uuid;
    alter table TMP_ADDROBJ  drop column nextid_x;


-- cast column TMP_ADDROBJ .regioncode to int

    alter table TMP_ADDROBJ  rename column regioncode to regioncode_x;
    alter table TMP_ADDROBJ  add column regioncode int;
    update TMP_ADDROBJ  set regioncode = regioncode_x::int;
    alter table TMP_ADDROBJ  drop column regioncode_x;

-- cast column TMP_ADDROBJ .actstatus to int

    alter table TMP_ADDROBJ  rename column actstatus to actstatus_x;
    alter table TMP_ADDROBJ  add column actstatus int;
    update TMP_ADDROBJ  set actstatus = actstatus_x::int;
    alter table TMP_ADDROBJ  drop column actstatus_x;


-- cast column TMP_ADDROBJ .level to int

    alter table TMP_ADDROBJ  rename column level to aolevel_x;
    alter table TMP_ADDROBJ  add column level int;
    update TMP_ADDROBJ  set level = aolevel_x::int;
    alter table TMP_ADDROBJ  drop column aolevel_x;


-- cast column TMP_ADDROBJ .currstatus to int

    alter table TMP_ADDROBJ  rename column currstatus to currstatus_x;
    alter table TMP_ADDROBJ  add column currstatus int;
    update TMP_ADDROBJ  set currstatus = currstatus_x::int;
    alter table TMP_ADDROBJ  drop column currstatus_x;


-- cast column TMP_ADDROBJ .livestatus to int

    alter table TMP_ADDROBJ  rename column livestatus to livestatus_x;
    alter table TMP_ADDROBJ  add column livestatus int;
    update TMP_ADDROBJ  set livestatus = livestatus_x::int;
    alter table TMP_ADDROBJ  drop column livestatus_x;


-- cast column TMP_ADDROBJ .operstatus to int

    alter table TMP_ADDROBJ  rename column operstatus to operstatus_x;
    alter table TMP_ADDROBJ  add column operstatus int;
    update TMP_ADDROBJ  set operstatus = operstatus_x::int;
    alter table TMP_ADDROBJ  drop column operstatus_x;

select * from public addrobj 

UPDATE TMP_ADDROBJ SET kod_t_st = socrbase.kod_t_st
  FROM socrbase WHERE socrbase.scname = TMP_ADDROBJ.shortname AND socrbase.level = TMP_ADDROBJ.aolevel;

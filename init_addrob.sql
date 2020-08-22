ALTER TABLE TMP_ADDROB
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

ALTER TABLE TMP_ADDROB RENAME COLUMN  formalname TO name;
ALTER TABLE TMP_ADDROB RENAME COLUMN  aoguid TO guid;
ALTER TABLE TMP_ADDROB RENAME COLUMN  aoid TO id;
ALTER TABLE TMP_ADDROB RENAME COLUMN  aolevel TO level;


-- update empty values for TMP_ADDROB .nextid
UPDATE TMP_ADDROB  SET nextid = NULL WHERE nextid = '';

--- update empty values for TMP_ADDROB .previd
UPDATE TMP_ADDROB  SET previd = NULL WHERE previd = '';

--- update empty values for TMP_ADDROB .parentguid
UPDATE TMP_ADDROB  SET parentguid = NULL WHERE parentguid = '';

--- update empty values for TMP_ADDROB .enddate
--- UPDATE TMP_ADDROB  SET enddate = NULL WHERE enddate = '';

--- update empty values for TMP_ADDROB .startdate
--- UPDATE TMP_ADDROB  SET startdate = NULL WHERE startdate = '';

--- update empty values for TMP_ADDROB .postalcode
UPDATE TMP_ADDROB  SET postalcode = NULL WHERE postalcode = '';

-- cast column TMP_ADDROB .guid to uuid

    alter table TMP_ADDROB  rename column guid to aoguid_x;
    alter table TMP_ADDROB  add column guid uuid;
    update TMP_ADDROB  set guid = aoguid_x::uuid;
    alter table TMP_ADDROB  drop column aoguid_x;


-- cast column TMP_ADDROB .id to uuid

    alter table TMP_ADDROB  rename column id to aoid_x;
    alter table TMP_ADDROB  add column id uuid;
    update TMP_ADDROB  set id = aoid_x::uuid;
    alter table TMP_ADDROB  drop column aoid_x;


-- cast column TMP_ADDROB .parentguid to uuid

    alter table TMP_ADDROB  rename column parentguid to parentguid_x;
    alter table TMP_ADDROB  add column parentguid uuid;
    update TMP_ADDROB  set parentguid = parentguid_x::uuid;
    alter table TMP_ADDROB  drop column parentguid_x;


-- cast column TMP_ADDROB .previd to uuid

    alter table TMP_ADDROB  rename column previd to previd_x;
    alter table TMP_ADDROB  add column previd uuid;
    update TMP_ADDROB  set previd = previd_x::uuid;
    alter table TMP_ADDROB  drop column previd_x;


-- cast column TMP_ADDROB .nextid to uuid

    alter table TMP_ADDROB  rename column nextid to nextid_x;
    alter table TMP_ADDROB  add column nextid uuid;
    update TMP_ADDROB  set nextid = nextid_x::uuid;
    alter table TMP_ADDROB  drop column nextid_x;


-- cast column TMP_ADDROB .regioncode to int

    alter table TMP_ADDROB  rename column regioncode to regioncode_x;
    alter table TMP_ADDROB  add column regioncode int;
    update TMP_ADDROB  set regioncode = regioncode_x::int;
    alter table TMP_ADDROB  drop column regioncode_x;

-- cast column TMP_ADDROB .actstatus to int

    alter table TMP_ADDROB  rename column actstatus to actstatus_x;
    alter table TMP_ADDROB  add column actstatus int;
    update TMP_ADDROB  set actstatus = actstatus_x::int;
    alter table TMP_ADDROB  drop column actstatus_x;


-- cast column TMP_ADDROB .level to int

    alter table TMP_ADDROB  rename column level to aolevel_x;
    alter table TMP_ADDROB  add column level int;
    update TMP_ADDROB  set level = aolevel_x::int;
    alter table TMP_ADDROB  drop column aolevel_x;


-- cast column TMP_ADDROB .currstatus to int

    alter table TMP_ADDROB  rename column currstatus to currstatus_x;
    alter table TMP_ADDROB  add column currstatus int;
    update TMP_ADDROB  set currstatus = currstatus_x::int;
    alter table TMP_ADDROB  drop column currstatus_x;


-- cast column TMP_ADDROB .livestatus to int

    alter table TMP_ADDROB  rename column livestatus to livestatus_x;
    alter table TMP_ADDROB  add column livestatus int;
    update TMP_ADDROB  set livestatus = livestatus_x::int;
    alter table TMP_ADDROB  drop column livestatus_x;


-- cast column TMP_ADDROB .operstatus to int

    alter table TMP_ADDROB  rename column operstatus to operstatus_x;
    alter table TMP_ADDROB  add column operstatus int;
    update TMP_ADDROB  set operstatus = operstatus_x::int;
    alter table TMP_ADDROB  drop column operstatus_x;

select * from public addrobj 

UPDATE TMP_ADDROB SET kod_t_st = socrbase.kod_t_st
  FROM socrbase WHERE socrbase.scname = TMP_ADDROB.shortname AND socrbase.level = TMP_ADDROB.aolevel;

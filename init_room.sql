ALTER TABLE TMP_ROOM
DROP COLUMN  normdoc,
ADD COLUMN kod_t_st INTEGER;


ALTER TABLE TMP_ROOM RENAME COLUMN  roomid TO id;
ALTER TABLE TMP_ROOM RENAME COLUMN  roomguid TO guid;
ALTER TABLE TMP_ROOM RENAME COLUMN  houseguid TO parentguid;


--- update empty values for TMP_ROOM .parentguid
UPDATE TMP_ROOM  SET parentguid = NULL WHERE parentguid = '';

--- update empty values for TMP_ROOM .previd
UPDATE TMP_ROOM  SET previd = NULL WHERE previd = '';

--- update empty values for TMP_ROOM .nextid
UPDATE TMP_ROOM  SET nextid = NULL WHERE nextid = '';

--- update empty values for TMP_ROOM .enddate
--- UPDATE TMP_ROOM  SET enddate = NULL WHERE enddate = '';

--- update empty values for TMP_ROOM .startdate
--- UPDATE TMP_ROOM  SET startdate = NULL WHERE startdate = '';

--- update empty values for TMP_ROOM .postalcode
UPDATE TMP_ROOM  SET postalcode = NULL WHERE postalcode = '';

-- cast column TMP_ROOM .guid to uuid
    alter table TMP_ROOM  rename column guid to aoguid_x;
    alter table TMP_ROOM  add column guid uuid;
    update TMP_ROOM  set guid = aoguid_x::uuid;
    alter table TMP_ROOM  drop column aoguid_x;

-- cast column TMP_ROOM .id to uuid
    alter table TMP_ROOM  rename column id to aoid_x;
    alter table TMP_ROOM  add column id uuid;
    update TMP_ROOM  set id = aoid_x::uuid;
    alter table TMP_ROOM  drop column aoid_x;

-- cast column TMP_ROOM .parentguid to uuid
    alter table TMP_ROOM  rename column parentguid to parentguid_x;
    alter table TMP_ROOM  add column parentguid uuid;
    update TMP_ROOM  set parentguid = parentguid_x::uuid;
    alter table TMP_ROOM  drop column parentguid_x;

-- cast column TMP_ROOM .previd to uuid
    alter table TMP_ROOM  rename column previd to previd_x;
    alter table TMP_ROOM  add column previd uuid;
    update TMP_ROOM  set previd = previd_x::uuid;
    alter table TMP_ROOM  drop column previd_x;

-- cast column TMP_ROOM .nextid to uuid
    alter table TMP_ROOM  rename column nextid to nextid_x;
    alter table TMP_ROOM  add column nextid uuid;
    update TMP_ROOM  set nextid = nextid_x::uuid;
    alter table TMP_ROOM  drop column nextid_x;


	


-- cast column TMP_ROOM .regioncode to int
    alter table TMP_ROOM  rename column regioncode to regioncode_x;
    alter table TMP_ROOM  add column regioncode int;
    update TMP_ROOM  set regioncode = regioncode_x::int;
    alter table TMP_ROOM  drop column regioncode_x;


-- cast column TMP_ROOM .livestatus to int
    alter table TMP_ROOM  rename column livestatus to livestatus_x;
    alter table TMP_ROOM  add column livestatus int;
    update TMP_ROOM  set livestatus = livestatus_x::int;
    alter table TMP_ROOM  drop column livestatus_x;

-- cast column TMP_ROOM .operstatus to int
    alter table TMP_ROOM  rename column operstatus to operstatus_x;
    alter table TMP_ROOM  add column operstatus int;
    update TMP_ROOM  set operstatus = operstatus_x::int;
    alter table TMP_ROOM  drop column operstatus_x;




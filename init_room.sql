ALTER TABLE TMP_STEAD
DROP COLUMN  normdoc,
ADD COLUMN kod_t_st INTEGER;


ALTER TABLE TMP_STEAD RENAME COLUMN  roomid TO id;
ALTER TABLE TMP_STEAD RENAME COLUMN  roomguid TO guid;
ALTER TABLE TMP_STEAD RENAME COLUMN  houseguid TO parentguid;


--- update empty values for TMP_STEAD .parentguid
UPDATE TMP_STEAD  SET parentguid = NULL WHERE parentguid = '';

--- update empty values for TMP_STEAD .previd
UPDATE TMP_STEAD  SET previd = NULL WHERE previd = '';

--- update empty values for TMP_STEAD .nextid
UPDATE TMP_STEAD  SET nextid = NULL WHERE nextid = '';

--- update empty values for TMP_STEAD .enddate
--- UPDATE TMP_STEAD  SET enddate = NULL WHERE enddate = '';

--- update empty values for TMP_STEAD .startdate
--- UPDATE TMP_STEAD  SET startdate = NULL WHERE startdate = '';

--- update empty values for TMP_STEAD .postalcode
UPDATE TMP_STEAD  SET postalcode = NULL WHERE postalcode = '';

-- cast column TMP_STEAD .guid to uuid
    alter table TMP_STEAD  rename column guid to aoguid_x;
    alter table TMP_STEAD  add column guid uuid;
    update TMP_STEAD  set guid = aoguid_x::uuid;
    alter table TMP_STEAD  drop column aoguid_x;

-- cast column TMP_STEAD .id to uuid
    alter table TMP_STEAD  rename column id to aoid_x;
    alter table TMP_STEAD  add column id uuid;
    update TMP_STEAD  set id = aoid_x::uuid;
    alter table TMP_STEAD  drop column aoid_x;

-- cast column TMP_STEAD .parentguid to uuid
    alter table TMP_STEAD  rename column parentguid to parentguid_x;
    alter table TMP_STEAD  add column parentguid uuid;
    update TMP_STEAD  set parentguid = parentguid_x::uuid;
    alter table TMP_STEAD  drop column parentguid_x;

-- cast column TMP_STEAD .previd to uuid
    alter table TMP_STEAD  rename column previd to previd_x;
    alter table TMP_STEAD  add column previd uuid;
    update TMP_STEAD  set previd = previd_x::uuid;
    alter table TMP_STEAD  drop column previd_x;

-- cast column TMP_STEAD .nextid to uuid
    alter table TMP_STEAD  rename column nextid to nextid_x;
    alter table TMP_STEAD  add column nextid uuid;
    update TMP_STEAD  set nextid = nextid_x::uuid;
    alter table TMP_STEAD  drop column nextid_x;


	


-- cast column TMP_STEAD .regioncode to int
    alter table TMP_STEAD  rename column regioncode to regioncode_x;
    alter table TMP_STEAD  add column regioncode int;
    update TMP_STEAD  set regioncode = regioncode_x::int;
    alter table TMP_STEAD  drop column regioncode_x;


-- cast column TMP_STEAD .livestatus to int
    alter table TMP_STEAD  rename column livestatus to livestatus_x;
    alter table TMP_STEAD  add column livestatus int;
    update TMP_STEAD  set livestatus = livestatus_x::int;
    alter table TMP_STEAD  drop column livestatus_x;

-- cast column TMP_STEAD .operstatus to int
    alter table TMP_STEAD  rename column operstatus to operstatus_x;
    alter table TMP_STEAD  add column operstatus int;
    update TMP_STEAD  set operstatus = operstatus_x::int;
    alter table TMP_STEAD  drop column operstatus_x;




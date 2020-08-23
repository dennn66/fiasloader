
ALTER TABLE TMP_HOUSE
DROP COLUMN counter,
DROP COLUMN ifnsfl,
DROP COLUMN ifnsul,
DROP COLUMN okato,
DROP COLUMN  oktmo,
DROP COLUMN  terrifnsfl,
DROP COLUMN  terrifnsul,
DROP COLUMN  normdoc,
ADD COLUMN kod_t_st INTEGER,
ADD COLUMN regioncode VARCHAR(2),
;
ALTER TABLE TMP_HOUSE RENAME COLUMN  houseid TO id;
ALTER TABLE TMP_HOUSE RENAME COLUMN  aoguid TO parentguid;
ALTER TABLE TMP_HOUSE RENAME COLUMN  houseguid TO guid;

COMMIT;

--

--- update empty values for TMP_HOUSE .parentguid
UPDATE TMP_HOUSE  SET parentguid = NULL WHERE parentguid = '';

--- update empty values for TMP_HOUSE .enddate
--- UPDATE TMP_HOUSE  SET enddate = NULL WHERE enddate = '';

--- update empty values for TMP_HOUSE .startdate
--- UPDATE TMP_HOUSE  SET startdate = NULL WHERE startdate = '';

--- update empty values for TMP_HOUSE .postalcode
UPDATE TMP_HOUSE  SET postalcode = NULL WHERE postalcode = '';

-- cast column TMP_HOUSE .guid to uuid

    alter table TMP_HOUSE  rename column guid to aoguid_x;
    alter table TMP_HOUSE  add column guid uuid;
    update TMP_HOUSE  set guid = aoguid_x::uuid;
    alter table TMP_HOUSE  drop column aoguid_x;


-- cast column TMP_HOUSE .id to uuid

    alter table TMP_HOUSE  rename column id to aoid_x;
    alter table TMP_HOUSE  add column id uuid;
    update TMP_HOUSE  set id = aoid_x::uuid;
    alter table TMP_HOUSE  drop column aoid_x;


-- cast column TMP_HOUSE .parentguid to uuid

    alter table TMP_HOUSE  rename column parentguid to parentguid_x;
    alter table TMP_HOUSE  add column parentguid uuid;
    update TMP_HOUSE  set parentguid = parentguid_x::uuid;
    alter table TMP_HOUSE  drop column parentguid_x;


-- cast column TMP_HOUSE .operstatus to int
BEGIN;
    alter table TMP_HOUSE  rename column operstatus to operstatus_x;
    alter table TMP_HOUSE  add column operstatus int;
    update TMP_HOUSE  set operstatus = operstatus_x::int;
    alter table TMP_HOUSE  drop column operstatus_x;
COMMIT;

-- cast column TMP_HOUSE .previd to uuid
BEGIN;
    alter table TMP_HOUSE  rename column previd to previd_x;
    alter table TMP_HOUSE  add column previd uuid;
    update TMP_HOUSE  set previd = previd_x::uuid;
    alter table TMP_HOUSE  drop column previd_x;
COMMIT;
-- strstatus | eststatus
CREATE INDEX strstatus_idx ON TMP_HOUSE USING btree (strstatus);
CREATE INDEX eststatus_idx ON TMP_HOUSE USING btree (eststatus);

ALTER TABLE TMP_HOUSE
ADD COLUMN str_shortname VARCHAR(50),
ADD COLUMN est_shortname VARCHAR(50)
;

UPDATE TMP_HOUSE SET est_shortname = eststat.shortname
FROM eststat WHERE eststat.eststatid = TMP_HOUSE.eststatus;

UPDATE TMP_HOUSE SET str_shortname = strstat.shortname
FROM strstat WHERE strstat.strstatid= TMP_HOUSE.strstatus;


UPDATE TMP_HOUSE SET kod_t_st = eststat.kod_t_st FROM eststat WHERE eststat.eststatid = TMP_HOUSE.eststatus;

UPDATE TMP_HOUSE SET kod_t_st = strstat.kod_t_st FROM strstat WHERE strstat.strstatid = TMP_HOUSE.strstatus and TMP_HOUSE.eststatus=0;
UPDATE TMP_HOUSE SET regioncode = addrob.regioncode where addrob.actstatus=1 AND addrob.guid = TMP_HOUSE.parentguid 





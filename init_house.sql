
ALTER TABLE TMP_HOUSE
DROP COLUMN counter,
DROP COLUMN ifnsfl,
DROP COLUMN ifnsul,
DROP COLUMN okato,
DROP COLUMN  oktmo,
DROP COLUMN  terrifnsfl,
DROP COLUMN  terrifnsul,
DROP COLUMN  normdoc,
ADD COLUMN regioncode INTEGER
;
ALTER TABLE TMP_HOUSE RENAME COLUMN  houseid TO id;
ALTER TABLE TMP_HOUSE RENAME COLUMN  aoguid TO parentguid;
ALTER TABLE TMP_HOUSE RENAME COLUMN  houseguid TO guid;

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









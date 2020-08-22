
--  strstatid |     name      |   shortname

BEGIN;
    alter table strstat rename column strstatid to strstatid_x;
    alter table strstat add column strstatid int;
    update strstat set strstatid = strstatid_x::int;
    alter table strstat drop column strstatid_x;
COMMIT;

ALTER TABLE strstat ADD COLUMN kod_t_st INTEGER;

CREATE TABLE str2socr (
    strstatid        integer CONSTRAINT str_firstkey PRIMARY KEY,
     kod_t_st       integer
);

INSERT INTO str2socr  (strstatid, kod_t_st)
VALUES
(0, null),
(1, 811),
(2, 810),
(3, 803);


UPDATE strstat SET kod_t_st = str2socr.kod_t_st
FROM str2socr WHERE str2socr.strstatid = strstat.strstatid;

CREATE UNIQUE INDEX strstat_idx ON strstat USING btree (strstatid);

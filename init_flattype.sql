
-- fltypeid |         name         |   shortname

BEGIN;
    alter table flattype rename column fltypeid to flattypeid_x;
    alter table flattype add column fltypeid int;
    update flattype set fltypeid = flattypeid_x::int;
    alter table flattype drop column flattypeid_x;
COMMIT;

ALTER TABLE flattype ADD COLUMN kod_t_st INTEGER;
CREATE TABLE IF NOT EXISTS flat2socr (
    fltypeid        integer CONSTRAINT fltypeid_pk PRIMARY KEY,
     kod_t_st       integer
);

INSERT INTO flat2socr  (fltypeid, kod_t_st)
VALUES
(0,	null),
(1,	907),
(2,	902),
(3,	904),
(4,	903),
(5,	908),
(6,	909),
(7,	910),
(8,	911),
(9,	809),
(10,	906),
(11,	807),
(12,	905),
(13,	901)
ON CONFLICT (fltypeid) DO NOTHING;

UPDATE flattype SET kod_t_st = flat2socr.kod_t_st
FROM flat2socr WHERE flat2socr.fltypeid = flattype.fltypeid;


CREATE UNIQUE INDEX flattypeid_idx ON flattype USING btree (fltypeid);

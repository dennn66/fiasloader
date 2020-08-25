
-- rmtypeid |         name         |   shortname

BEGIN;
    alter table roomtype rename column rmtypeid to roomtypeid_x;
    alter table roomtype add column rmtypeid int;
    update roomtype set rmtypeid = roomtypeid_x::int;
    alter table roomtype drop column roomtypeid_x;
COMMIT;

ALTER TABLE roomtype ADD COLUMN kod_t_st INTEGER;
CREATE TABLE IF NOT EXISTS room2socr (
    rmtypeid        integer CONSTRAINT firstkey PRIMARY KEY,
     kod_t_st       integer
);

INSERT INTO room2socr  (rmtypeid, kod_t_st)
VALUES
(0,	null),
(1,	903),
(2,	907)


ON CONFLICT (rmtypeid) DO NOTHING;

UPDATE roomtype SET kod_t_st = room2socr.kod_t_st
FROM room2socr WHERE room2socr.rmtypeid = roomtype.rmtypeid;

CREATE UNIQUE INDEX roomtypeid_idx ON roomtype USING btree (rmtypeid);

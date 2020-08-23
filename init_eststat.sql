
-- eststatid |         name         |   shortname

BEGIN;
    alter table eststat rename column eststatid to eststatid_x;
    alter table eststat add column eststatid int;
    update eststat set eststatid = eststatid_x::int;
    alter table eststat drop column eststatid_x;
COMMIT;

ALTER TABLE eststat ADD COLUMN kod_t_st INTEGER;
CREATE TABLE IF NOT EXISTS est2socr (
    eststatid        integer CONSTRAINT firstkey PRIMARY KEY,
     kod_t_st       integer
);

INSERT INTO est2socr  (eststatid, kod_t_st)
VALUES
(0, null),
(1, 802),
(2, 803),
(3, 804),
(4, 901),
(5, 805),
(6, 812),
(7, 906),
(8, 807),
(9, 905),
(10, 808)
ON CONFLICT (eststatid) DO NOTHING;


UPDATE eststat SET kod_t_st = est2socr.kod_t_st
FROM est2socr WHERE est2socr.eststatid = eststat.eststatid;


CREATE UNIQUE INDEX eststatid_idx ON eststat USING btree (eststatid);

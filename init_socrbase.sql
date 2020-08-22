
-- cast column socrbase.level to int
BEGIN;
    alter table socrbase rename column level to level_x;
    alter table socrbase add column level int;
    update socrbase set level = level_x::int;
    alter table socrbase drop column level_x;
COMMIT;
BEGIN;
    alter table socrbase rename column kod_t_st to kod_t_st_x;
    alter table socrbase add column kod_t_st int;
    update socrbase set kod_t_st = kod_t_st_x::int;
    alter table socrbase drop column kod_t_st_x;
COMMIT;
CREATE UNIQUE INDEX kod_t_st_idx ON socrbase USING btree (kod_t_st);
CREATE INDEX scname_level_idx ON socrbase USING btree (scname, level);

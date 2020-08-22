BEGIN;
    alter table operstat rename column operstatid to operstatid_x;
    alter table operstat add column operstatid int;
    update operstat set operstatid = operstatid_x::int;
    alter table operstat drop column operstatid_x;
COMMIT;
CREATE UNIQUE INDEX operstat_idx ON operstat USING btree (operstatid);
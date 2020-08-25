--  create btree indexes
CREATE  UNIQUE INDEX ao_guid_idx ON AO USING btree (guid);
CREATE INDEX ao_parentguid_idx ON AO USING btree (parentguid);
CREATE INDEX ao_livestatus_idx ON AO USING btree (livestatus);
CREATE INDEX ao_name_idx ON AO USING btree (name);
CREATE INDEX ao_kod_t_st_idx ON AO USING btree (kod_t_st);

-- trigram indexes to speed up text searches
CREATE INDEX ao_name_trgm_idx on AO USING gin (name gin_trgm_ops);


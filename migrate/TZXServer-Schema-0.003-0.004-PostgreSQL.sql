-- Convert schema 'migrate/TZXServer-Schema-0.003-PostgreSQL.sql' to 'migrate/TZXServer-Schema-0.004-PostgreSQL.sql':;

BEGIN;

ALTER TABLE tape_files DROP CONSTRAINT tape_files_pkey;

ALTER TABLE tape_files ADD COLUMN id integer NOT NULL;

ALTER TABLE tape_files ADD COLUMN username text;

ALTER TABLE tape_files ADD PRIMARY KEY (id);


COMMIT;


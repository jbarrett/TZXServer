-- Convert schema 'migrate/TZXServer-Schema-0.003-MySQL.sql' to 'TZXServer::Schema v0.004':;

BEGIN;

ALTER TABLE tape_files DROP PRIMARY KEY,
                       ADD COLUMN id integer NOT NULL,
                       ADD COLUMN username text NULL,
                       CHANGE COLUMN tape_id tape_id integer NOT NULL,
                       CHANGE COLUMN filename filename text NOT NULL,
                       ADD PRIMARY KEY (id);


COMMIT;


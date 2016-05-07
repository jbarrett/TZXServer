-- Convert schema 'migrate/TZXServer-Schema-0.001-MySQL.sql' to 'TZXServer::Schema v0.002':;

BEGIN;

SET foreign_key_checks=0;

CREATE TABLE `tape_files` (
  `tape_id` integer NOT NULL,
  `filename` text NOT NULL,
  PRIMARY KEY (`tape_id`, `filename`)
);

SET foreign_key_checks=1;


COMMIT;


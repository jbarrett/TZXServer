-- Convert schema 'migrate/TZXServer-Schema-0.002-MySQL.sql' to 'TZXServer::Schema v0.003':;

BEGIN;

SET foreign_key_checks=0;

CREATE TABLE `users` (
  `username` text NOT NULL,
  `password` text NOT NULL,
  PRIMARY KEY (`username`)
);

SET foreign_key_checks=1;


COMMIT;


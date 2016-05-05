-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Thu May  5 18:10:39 2016
-- 

BEGIN TRANSACTION;

--
-- Table: tapes
--
DROP TABLE tapes;

CREATE TABLE tapes (
  id INTEGER PRIMARY KEY NOT NULL,
  title text NOT NULL,
  year smallint,
  genre text,
  publisher text,
  uri text
);

COMMIT;

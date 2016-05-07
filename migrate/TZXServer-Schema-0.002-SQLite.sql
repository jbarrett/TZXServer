-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sat May  7 16:46:57 2016
-- 

BEGIN TRANSACTION;

--
-- Table: tape_files
--
DROP TABLE tape_files;

CREATE TABLE tape_files (
  tape_id integer NOT NULL,
  filename text NOT NULL,
  PRIMARY KEY (tape_id, filename)
);

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

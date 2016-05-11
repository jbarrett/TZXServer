-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Sun May  8 21:42:51 2016
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
-- Table: users
--
DROP TABLE users;

CREATE TABLE users (
  username text NOT NULL,
  password text NOT NULL,
  PRIMARY KEY (username)
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

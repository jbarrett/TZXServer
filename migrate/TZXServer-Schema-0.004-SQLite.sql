-- 
-- Created by SQL::Translator::Producer::SQLite
-- Created on Wed May 11 19:21:33 2016
-- 

BEGIN TRANSACTION;

--
-- Table: tape_files
--
DROP TABLE tape_files;

CREATE TABLE tape_files (
  id INTEGER PRIMARY KEY NOT NULL,
  tape_id integer NOT NULL,
  filename text NOT NULL,
  username text
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

--
-- Table: users
--
DROP TABLE users;

CREATE TABLE users (
  username text NOT NULL,
  password text NOT NULL,
  PRIMARY KEY (username)
);

COMMIT;

-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Wed May 11 19:21:32 2016
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS tape_files;

--
-- Table: tape_files
--
CREATE TABLE tape_files (
  id integer NOT NULL,
  tape_id integer NOT NULL,
  filename text NOT NULL,
  username text NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS tapes;

--
-- Table: tapes
--
CREATE TABLE tapes (
  id integer NOT NULL auto_increment,
  title text NOT NULL,
  year smallint NULL,
  genre text NULL,
  publisher text NULL,
  uri text NULL,
  PRIMARY KEY (id)
);

DROP TABLE IF EXISTS users;

--
-- Table: users
--
CREATE TABLE users (
  username text NOT NULL,
  password text NOT NULL,
  PRIMARY KEY (username)
);

SET foreign_key_checks=1;


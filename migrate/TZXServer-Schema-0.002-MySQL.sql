-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Sat May  7 16:46:56 2016
-- 
SET foreign_key_checks=0;

DROP TABLE IF EXISTS tape_files;

--
-- Table: tape_files
--
CREATE TABLE tape_files (
  tape_id integer NOT NULL,
  filename text NOT NULL,
  PRIMARY KEY (tape_id, filename)
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

SET foreign_key_checks=1;


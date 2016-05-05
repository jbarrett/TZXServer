-- 
-- Created by SQL::Translator::Producer::MySQL
-- Created on Thu May  5 18:10:39 2016
-- 
SET foreign_key_checks=0;

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


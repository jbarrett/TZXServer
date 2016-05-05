-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Thu May  5 18:10:39 2016
-- 
--
-- Table: tapes
--
DROP TABLE tapes CASCADE;
CREATE TABLE tapes (
  id serial NOT NULL,
  title text NOT NULL,
  year smallint,
  genre text,
  publisher text,
  uri text,
  PRIMARY KEY (id)
);


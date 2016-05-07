-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Sat May  7 16:46:57 2016
-- 
--
-- Table: tape_files
--
DROP TABLE tape_files CASCADE;
CREATE TABLE tape_files (
  tape_id integer NOT NULL,
  filename text NOT NULL,
  PRIMARY KEY (tape_id, filename)
);

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


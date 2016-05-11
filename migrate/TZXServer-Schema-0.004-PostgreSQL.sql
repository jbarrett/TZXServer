-- 
-- Created by SQL::Translator::Producer::PostgreSQL
-- Created on Wed May 11 19:21:33 2016
-- 
--
-- Table: tape_files
--
DROP TABLE tape_files CASCADE;
CREATE TABLE tape_files (
  id integer NOT NULL,
  tape_id integer NOT NULL,
  filename text NOT NULL,
  username text,
  PRIMARY KEY (id)
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

--
-- Table: users
--
DROP TABLE users CASCADE;
CREATE TABLE users (
  username text NOT NULL,
  password text NOT NULL,
  PRIMARY KEY (username)
);


-- Convert schema 'migrate/TZXServer-Schema-0.001-PostgreSQL.sql' to 'migrate/TZXServer-Schema-0.002-PostgreSQL.sql':;

BEGIN;

CREATE TABLE "tape_files" (
  "tape_id" integer NOT NULL,
  "filename" text NOT NULL,
  PRIMARY KEY ("tape_id", "filename")
);


COMMIT;


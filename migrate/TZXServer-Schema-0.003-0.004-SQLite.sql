-- Convert schema 'migrate/TZXServer-Schema-0.003-SQLite.sql' to 'migrate/TZXServer-Schema-0.004-SQLite.sql':;

BEGIN;

CREATE TEMPORARY TABLE "tape_files_temp_alter" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "tape_id" integer NOT NULL,
  "filename" text NOT NULL,
  "username" text
);

INSERT INTO "tape_files_temp_alter"( "tape_id", "filename") SELECT "tape_id", "filename" FROM "tape_files";

DROP TABLE "tape_files";

CREATE TABLE "tape_files" (
  "id" INTEGER PRIMARY KEY NOT NULL,
  "tape_id" integer NOT NULL,
  "filename" text NOT NULL,
  "username" text
);

INSERT INTO "tape_files" SELECT "id", "tape_id", "filename", "username" FROM "tape_files_temp_alter";

DROP TABLE "tape_files_temp_alter";


COMMIT;


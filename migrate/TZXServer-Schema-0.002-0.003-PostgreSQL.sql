-- Convert schema 'migrate/TZXServer-Schema-0.002-PostgreSQL.sql' to 'migrate/TZXServer-Schema-0.003-PostgreSQL.sql':;

BEGIN;

CREATE TABLE "users" (
  "username" text NOT NULL,
  "password" text NOT NULL,
  PRIMARY KEY ("username")
);


COMMIT;


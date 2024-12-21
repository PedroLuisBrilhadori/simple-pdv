
SELECT 'CREATE DATABASE simplepdv'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'simplepdv')\gexec

\c simplepdv
CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE SCHEMA pdv;

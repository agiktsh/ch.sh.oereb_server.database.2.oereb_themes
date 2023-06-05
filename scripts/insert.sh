#!/bin/bash
set -Eeuo pipefail

ili2pg_executable=$(find /tmp/ili2pg -iname 'ili2pg*.jar')

java -jar "$ili2pg_executable" \
  --import \
  --replace \
  --dbdatabase "$POSTGRES_DB" \
  --dbusr gretl \
  --dbport 54321 \
  --dbhost localhost \
  --dbpwd "$PG_GRETL_PWD" \
  --dbschema "$SCHEMA" \
  --dataset "$(basename "$FILE" .xtf)" \
  --disableValidation \
  --models "OeREBKRMtrsfr_V2_0" \
  --verbose \
  --modeldir http://models.interlis.ch/ \
  "$FILE"

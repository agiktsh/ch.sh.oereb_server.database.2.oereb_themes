#!/bin/bash
set -Eeuo pipefail

ili2pg_executable=$(find /tmp/ili2pg -iname 'ili2pg*.jar')
# files=$(find . -type f -name "*.xtf")
files=./ch.Gewaesserraum-Gewaesserraum_V1_1-ch.Gewaesserraum.xtf \
ch.Planungszonen-Planungszonen_V1_1-ch.Planungszonen.xtf
echo "$files"
for file in $files; do
  java -jar "$ili2pg_executable" \
    --import \
    --replace \
    --dbdatabase "$POSTGRES_DB" \
    --dbusr gretl \
    --dbport 54321 \
    --dbhost localhost \
    --dbpwd "$PG_GRETL_PWD" \
    --dbschema "$SCHEMA" \
    --dataset "$(basename "$file" .xtf)" \
    --disableValidation \
    --models "OeREBKRMtrsfr_V2_0" \
    --verbose \
    --modeldir http://models.interlis.ch/ \
    "$file"
done

#!/bin/bash
set -Eeuo pipefail

ili2pg_executable=$(find /tmp/ili2pg -iname 'ili2pg*.jar')
# Das wird später benutzt damit alle Dateien integriert werden
files=$(find . -type f -name "*.xtf")
# uncomment this to directly try a file
# files=(
# "ch.Gewaesserraum-Gewaesserraum_V1_1-ch.SH.Gewaesserraum.xtf" \
# "ch.Laermempfindlichkeitsstufen-Laermempfindlichkeitsstufen_V1_2-ch.2939.Laermempfindlichkeitsstufen.OeREBKRMtrsfr_V2_0.xtf" \
# "ch.Laermempfindlichkeitsstufen-Laermempfindlichkeitsstufen_V1_2-ch.2951.Laermempfindlichkeitsstufen.xtf" \
# "ch.Nutzungsplanung-Nutzungsplanung_V1_2-ch.2920.Nutzungsplanung.xtf" \
# "ch.Nutzungsplanung-Nutzungsplanung_V1_2-ch.2939.Nutzungsplanung.xtf" \
# "ch.Planungszonen-Planungszonen_V1_1-ch.SH.Planungszonen.xtf" \
# )

echo "${files[*]}"
for file in ${files[*]}; do
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

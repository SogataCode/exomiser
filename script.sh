#!/bin/bash
CSV_FILE="$1"
TEMP_YML="./template.yml"

while IFS=, read -r sample vcf_path ped_path hpos; do
    if [ -z "${vcf_path}" ]; then
        echo "no file found for sample:${sample}"
        continue
    fi
    FORMATTED_HPO=$(echo "${hpos}" | tr ',' '\n' | awk '{if($1!="")printf "'\''%s'\''", $1; if(NR>0 && $1!="") printf ","}' | sed 's/,$//')
    OUT_YML="${sample}-config.yml"
    sed \
        -e 's|VCF_PATH|'"${vcf_path}"'|g' \
        -e 's|PED_PATH|'"${ped_path}"'|g' \
        -e 's|HPO_ID|'"$FORMATTED_HPO"'|g' \
        -e 's|OUT_NAME|'"${sample}"'|g' \
        -e 's|"||g'\
        "$TEMP_YML" > "$OUT_YML"
    echo "analysis based on $OUT_YML"

java -Xmx64g \
-Dspring.config.location=./application.properties \
-jar ./exomiser-cli-14.1.0.jar \
--analysis "$OUT_YML"

   done < <(tail -n +2  "$CSV_FILE" | tr -d '\r')

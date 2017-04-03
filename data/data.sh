#!/bin/sh -e

#set -x

mkdir -p data/

tail -n +2 full_city_list.txt | head -n -2 | while read line
do
    line=$(echo $line|tr -d "\"")
    country=$(echo $line|cut -d ";" -f 1)
    city=$(echo $line|cut -d ";" -f 2)
    id=$(echo $line|cut -d ";" -f 3)
    dirname="data/$(echo $country|tr '[:upper:]' '[:lower:]'|sed -e 's/ /_/g'|tr -d "\/"|tr -s "_")"
    mkdir -p ${dirname}
    cd ${dirname}
    echo "cd ${dirname}"
    wget -q http://worldweather.wmo.int/en/json/${id}_en.xml
    cityname=$(echo $city|tr '[:upper:]' '[:lower:]'|tr -d "\/"|sed -e 's/ /_/g'|tr -d "\/"|tr -s "_")
    mv ${id}_en.xml ${id}_${cityname}.xml
    cd ../../
done

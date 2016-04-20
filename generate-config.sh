#!/bin/bash
set -e

APP=$1

if [[ $APP == "" ]]; then
  echo "Missing app"
  exit 255
fi

echo "Generating config for ${APP}"
echo "--"

IFS=$'\n'
KEYS=$(etcdctl ls /config/$APP)

CONFIG_DIR=${CONFIG_DIR:=`echo $PWD`}
FILE="${CONFIG_DIR}/${APP}.env"

echo -n "" > ${FILE}
for KEY in ${KEYS[@]}
do
  VALUE=$(etcdctl get $KEY)
  KEY=$(echo ${KEY} | cut -d "/" -f 4)
  echo "${KEY}=${VALUE}" | tee -a ${FILE}
done

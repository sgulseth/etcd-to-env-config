#!/bin/bash
set -e
IFS=$'\n'

APP=$1

if [[ $APP == "" ]]; then
  APPS=$(etcdctl ls /config)

  for APP in ${APPS[@]}
  do
    $0 $(basename ${APP})
  done
else
  echo "Generating config for ${APP}"
  echo "--"

  KEYS=$(etcdctl ls /config/$APP)

  CONFIG_DIR=${CONFIG_DIR:=`echo $PWD`}
  FILE="${CONFIG_DIR}/${APP}.env"

  echo -n "" > ${FILE}
  for KEY in ${KEYS[@]}
  do
    VALUE=$(etcdctl get $KEY)
    KEY=$(basename ${KEY})
    echo "${KEY}=${VALUE}" | tee -a ${FILE}
  done
fi
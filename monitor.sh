#!/usr/bin/env bash
LOG_FILE="$1"
MAIL_TO="alert@project.com"

tail -n0 -F ${LOG_FILE} | while IFS= read -r LOG_LINE; do
    STATUS=`echo ${LOG_LINE} | awk '{ print $9 }'`
    if [ x${STATUS} == x500 ]; then
        FILE_PATH=`echo ${LOG_LINE} | awk '{ print $7 }'`
        mail ${MAIL_TO} "HTTP ${STATUS} on ${FILE_PATH}"
    fi
done
#!/usr/bin/env bash

BACKUPS_NUM='{{ backup_number }}'
BACKUPS_DIR='{{ backup_directory }}'
BUCKET_NAME='{{ backup_bucket_name }}'
# Find most recent archive
ARCHIVES=$(ls -Art ${BACKUPS_DIR} | tail -n ${BACKUPS_NUM})

for ARCHIVE in ${ARCHIVES}; do
    echo "Uploading: ${ARCHIVE} >> ${BUCKET_NAME}"
    /usr/bin/s3cmd put "${BACKUPS_DIR}/${ARCHIVE}" "${BUCKET_NAME}"
done

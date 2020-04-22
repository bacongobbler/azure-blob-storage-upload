#!/bin/sh

set -e

if [ -z "$INPUT_SOURCE_DIR" ]; then
  echo "source directory is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_CONTAINER_NAME" ]; then
  echo "storage account container name is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_CONNECTION_STRING" ]; then
  echo "storage account connection string is not set. Quitting."
  exit 1
fi

EXTRA_ARGS=${INPUT_EXTRA_ARGS:""}

VERB="upload-batch"
if [ -z "$INPUT_SYNC" ]; then
  VERB="sync"
fi
az storage blob ${VERB} --connection-string ${INPUT_CONNECTION_STRING} -s ${INPUT_SOURCE_DIR} -d ${INPUT_CONTAINER_NAME} ${EXTRA_ARGS}

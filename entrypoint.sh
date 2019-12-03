#!/bin/sh

set -e

if [ -z "$INPUT_SOURCE_DIR" ]; then
  echo "source directory is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_CONNECTION_STRING" ]; then
  echo "connection string is not set. Quitting."
  exit 1
fi

EXTRA_ARGS=${INPUT_EXTRA_ARGS:""}


# Upload source to storage
az storage blob upload-batch --connection-string ${INPUT_CONNECTION_STRING} -s ${INPUT_SOURCE_DIR} ${EXTRA_ARGS}

#!/bin/bash

set -e

if [ -z "$INPUT_SOURCE_PATH" ]; then
    2>&1 echo "source directory is not set. Quitting."
    exit 1
fi

if [ -z "$INPUT_DESTINATION_PATH" ]; then
    2>&1 echo "destination directory is not set. Defaulting to '/'."
    INPUT_DESTINATION_PATH="/"
fi

if [ -z "$INPUT_CONTAINER_NAME" ]; then
    2>&1 echo "storage account container name is not set. Quitting."
    exit 1
fi

if [ -z "$INPUT_CONNECTION_STRING" ]; then
    2>&1 echo "storage account connection string is not set. Quitting."
    exit 1
fi

EXTRA_ARGS=${INPUT_EXTRA_ARGS:-}

# See <https://docs.microsoft.com/en-us/cli/azure/storage/blob?view=azure-cli-latest> for details
az storage blob upload-batch \
    --connection-string "${INPUT_CONNECTION_STRING}" \
    --source "${INPUT_SOURCE_PATH}" \
    --destination "${INPUT_CONTAINER_NAME}" \
    --destination-path "${INPUT_DESTINATION_PATH}" \
    "${EXTRA_ARGS}"

#!/usr/bin/env bash

set -e

if [ -z "$INPUT_SOURCE_DIR" ]; then
  echo "source directory is not set. Quitting."
  exit 1
fi

if [ -z "$INPUT_CONTAINER_NAME" ]; then
  echo "storage account container name is not set. Quitting."
  exit 1
fi

CONNECTION_METHOD=""

if ! [ -z "$INPUT_CONNECTION_STRING" ]; then
  CONNECTION_METHOD="--connection-string $INPUT_CONNECTION_STRING"
elif ! [ -z "$INPUT_SAS_TOKEN" ]; then
  if ! [ -z "$INPUT_ACCOUNT_NAME" ]; then
    CONNECTION_METHOD="--sas-token $INPUT_SAS_TOKEN --account-name $INPUT_ACCOUNT_NAME"
  else
    echo "account_name is required if using a sas_token. account_name is not set. Quitting."
    exit 1
  fi
else
  echo "either connection_string or sas_token are required and neither is set. Quitting."
  exit 1
fi

ARG_OVERWRITE=""
if [[ -v ${INPUT_OVERWRITE} ]]; then
  ARG_OVERWRITE="--overwrite true"
fi

EXTRA_ARGS=""
if [[ -v ${INPUT_EXTRA_ARGS} ]]; then
  EXTRA_ARGS=${INPUT_EXTRA_ARGS}
fi

VERB="upload-batch"
CONTAINER_NAME_FLAG="--destination"
if [[ -v ${INPUT_SYNC} ]]; then
  VERB="sync"
  CONTAINER_NAME_FLAG="--container"
fi

CLI_VERSION=""
if [[ -v ${INPUT_CLI_VERSION} ]]; then
  CLI_VERSION="==${INPUT_CLI_VERSION}"
fi

# install the azure cli
pip install azure-cli${CLI_VERSION}

az storage blob ${VERB} ${CONNECTION_METHOD} --source ${INPUT_SOURCE_DIR} ${CONTAINER_NAME_FLAG} ${INPUT_CONTAINER_NAME} ${ARG_OVERWRITE} ${EXTRA_ARGS}

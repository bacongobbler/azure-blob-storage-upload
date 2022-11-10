#!/usr/bin/env bash

set -e

if [[ -z "$INPUT_SOURCE_DIR" ]]; then
  echo "source directory is not set. Quitting."
  exit 1
fi

if [[ -z "$INPUT_CONTAINER_NAME" ]]; then
  echo "storage account container name is not set. Quitting."
  exit 1
fi

CONNECTION_METHOD=""

if [[ -n "$INPUT_CONNECTION_STRING" ]]; then
  CONNECTION_METHOD="--connection-string $INPUT_CONNECTION_STRING"
elif [[ -n "$INPUT_SAS_TOKEN" ]]; then
  if [[ -n "$INPUT_ACCOUNT_NAME" ]]; then
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
if [[ -n ${INPUT_OVERWRITE} ]]; then
  ARG_OVERWRITE="--overwrite true"
fi

EXTRA_ARGS=""
if [[ -n ${INPUT_EXTRA_ARGS} ]]; then
  EXTRA_ARGS=${INPUT_EXTRA_ARGS}
fi

VERB="upload-batch"
CONTAINER_NAME_FLAG="--destination"
if [[ -n ${INPUT_SYNC} ]]; then
  VERB="sync"
  CONTAINER_NAME_FLAG="--container"
fi

CLI_VERSION=""
if [[ -n ${INPUT_CLI_VERSION} ]]; then
  CLI_VERSION="==${INPUT_CLI_VERSION}"
fi

az storage blob ${VERB} ${CONNECTION_METHOD} --source ${INPUT_SOURCE_DIR} ${CONTAINER_NAME_FLAG} ${INPUT_CONTAINER_NAME} ${ARG_OVERWRITE} ${EXTRA_ARGS}

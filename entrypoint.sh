#!/bin/sh

echo "${INPUT_KEY}" > key
if [[ -f $INPUT_LOCAL ]]; then
  FILE_ARGS="-p ${INPUT_LOCAL}"
elif [[ -d $INPUT_LOCAL ]]; then
  FILE_ARGS="-rp ${INPUT_LOCAL}"
elif
  return 1;
fi;

chmod 600 key

scp -o StrictHostKeyChecking=no -v -i ./key -P "${INPUT_PORT}" "${FILE_ARGS}" "${INPUT_USER}"@"${INPUT_HOST}":"${INPUT_REMOTE}"
if [ ! -z "${INPUT_COMMAND}" ]; then
  ssh -o StrictHostKeyChecking=no -v -i ./key -p "${INPUT_PORT}" "${INPUT_USER}"@"${INPUT_HOST}" "${INPUT_COMMAND}"
fi;

rm -rf ./key

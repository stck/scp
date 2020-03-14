#!/bin/sh

echo "${INPUT_KEY}" > key
if [[ -f $INPUT_LOCAL ]]; then
  FILE_ARGS="-p ./${INPUT_LOCAL}"
elif [[ -d $INPUT_LOCAL ]]; then
  FILE_ARGS="-rp ./${INPUT_LOCAL}"
else
  return 1;
fi;

echo "${FILE_ARGS}"

chmod 600 key
if [ ! -z "${INPUT_PRECOPY}" ]; then
  echo "ssh -o StrictHostKeyChecking=no -v -i ./key -p $INPUT_PORT $INPUT_USER@$INPUT_HOST '${INPUT_PRECOPY}'"
fi;
scp -o StrictHostKeyChecking=no -v -i ./key -P $INPUT_PORT $FILE_ARGS $INPUT_USER@$INPUT_HOST:$INPUT_REMOTE
if [ ! -z "${INPUT_COMMAND}" ]; then
  echo "ssh -o StrictHostKeyChecking=no -v -i ./key -p $INPUT_PORT $INPUT_USER@$INPUT_HOST '${INPUT_COMMAND}'"
fi;

rm -rf ./key

#!/usr/bin/env bash
export PKG=golang.tar.gz
export API_PACKAGE=${ACTUAL}/${PKG}
export USER=deploy
export DEPLOY_PATH=/var/www/iver.mx/
export PORT=22

RAMA=`git branch -a| grep \* | cut -d ' ' -f2`;

echo "Rama->${RAMA}";

if [[ "${RAMA}" == *"HEAD"* ]]; then
  RAMA=${TRAVIS_BRANCH}
fi

echo "Current branch is: ${RAMA}";
if [ "${RAMA}" = "master" ]; then
  TARGET=iver.mx
else
  TARGET=iver.mx
fi

export TARGET
if [ ! -f $API_PACKAGE ]; then
  echo "Web files are not yet ready. Use make package."
  exit 1;
fi

echo "Subiendo archivos al servidor";
scp -vv -P 22 -i ${ACTUAL}/.deploy/deploy.id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null $API_PACKAGE $USER@$TARGET:/tmp;

ssh -vv -p 22 -i ${ACTUAL}/.deploy/deploy.id -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -l $USER $TARGET "
  sudo /usr/local/bin/deploy.sh;
";

echo "Eliminando zip...";
rm $API_PACKAGE;
echo "Done!";


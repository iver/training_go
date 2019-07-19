#!/usr/bin/env bash

TAGS=`git fetch --tags`
VERSION=`git describe --abbrev=0 --tags`
HASH=`git rev-parse --short HEAD`
VERSION_NAME="${VERSION}-${HASH}"

TARGET=${ACTUAL}/htdocs/version.html;

echo "Version: ${VERSION_NAME}" > ${TARGET};

head ${TARGET};

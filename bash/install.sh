#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

echo "Installing minify package from github.com/tdewolff";
go get -v github.com/tdewolff/minify/cmd/minify && echo "Done!!" || { echo "Error downloading minify package"; exit 1; };

mkdir -p ${ACTUAL}/data;
mkdir -p ${ACTUAL}/i18n;
mkdir -p ${ACTUAL}/log;


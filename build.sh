#!/bin/bash
rm -rf dist &&
mkdir -p ./dist/Received/ &&
cp *.lua ./dist/Received/ &&
cp *.toc ./dist/Received/ &&
cd dist &&
zip -r ./Received.zip ./Received &&
echo 'created file: '$(pwd -P ./dist/Received.zip)/dist/Received.zip

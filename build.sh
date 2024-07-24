#! /bin/bash

if [ ! -d dist ]; then
  mkdir dist
fi

cp -r src/assets dist/
sed "s;%MAIN_CONTENT%;$(head -n1 songs.txt);g" src/index.html > dist/index.html

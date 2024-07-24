#! /bin/bash

cp -r src/assets dist/
sed "s;%MAIN_CONTENT%;$(head -n1 songs.txt);" src/index.html > dist/index.html

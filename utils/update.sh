#!/bin/bash
echo $(cd $(dirname $0);pwd)
rm _ma.tar.gz
mv ma.tar.gz _ma.tar.gz

wget http://agripc@agripc.sakura.ne.jp/ma.tar.gz 

rm -r ma_ 
mv ma ma_

tar zxf ma.tar.gz 

cp -r ma_/config ma
cp -r ma_/thermo_data ma
cp -r ma_/log ma
#read -p "Complete. Press [Enter] key."

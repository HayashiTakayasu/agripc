#!/bin/bash
echo `date +"%Y/%m/%d %H:%M:%S"` > /home/pi/Desktop/ma/update.txt
tar zcf ma.tar.gz ma
scp -i ../y2 ma.tar.gz agripc@agripc.sakura.ne.jp:./www


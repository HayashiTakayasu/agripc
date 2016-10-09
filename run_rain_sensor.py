#!/usr/bin/python
# coding: UTF-8
import sys
f = open('rain.txt')
dat = f.read()  # ファイル終端まで全て読んだデータを返す
f.close()
sys.stdout.write(dat)
#print dat
exit(0)

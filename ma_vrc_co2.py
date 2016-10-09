#!/usr/bin/python
from serial import Serial
#import Serial
import os
import sys
import signal, time  
  
PIDFILE='./app.pid'  
pid=str(os.getpid())  
f=open(PIDFILE, 'w')  
f.write(pid)  
f.close()

argvs=sys.argv
argc=len(argvs)
if (argc >= 2): 
  ports=argvs[1]
else:
  ports="/dev/ttyUSB0"


com = Serial(
  port=ports,
  baudrate=19200,
  bytesize=8,
  parity='N',
  stopbits=1,
  timeout=1,#None,
  xonxoff=0,
  rtscts=0,
  writeTimeout=1,#None,
  dsrdtr=None)

#print com.portstr
#com.write("%01#RDD0000000015**\r")
com.flush()

i=0
while i<3:
  res=com.read(1)
  if res=="\002":
    res=res+com.read(26)
    break
  else:
    #pass
    i=i+1
    time.sleep(0.5)

com.close()

#print len(res)
print res
if len(res)==27:
  #pass
  with open('ma.txt', 'w+b') as file:
    file.write(res)
else:
  with open('ma_error.txt', 'a+') as file:
    file.write(res)
    file.write("__")
    file.write(str(i))
    file.write("\n")
    


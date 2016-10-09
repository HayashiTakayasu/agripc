import RPi.GPIO as GPIO
import time
GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)
##raspicomm input(5v or 3.3v)
#gpio4 (pin7) =input1 by raspicomm
#gpio25(pin22) =input2 by raspicomm
#gpio24(pin18) =input3 by raspicomm
#gpio23(pin16) =input4 by raspicomm
#gpio22(pin15) =input5 by raspicomm

#GPIO.setup(4,GPIO.IN)
GPIO.setup(4,GPIO.IN)
input5=GPIO.input(4) #True or False
print input5

exit(0)

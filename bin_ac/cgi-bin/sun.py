import ephem
import datetime
 
sun=ephem.Sun()
moon=ephem.Moon()
gifu=ephem.Observer()
gifu.lon='136.751601'
gifu.lat='35.469531'
gifu.elevation=15.0
print "now:",gifu.date
##today UTC
tdatetime = datetime.datetime.now()
tstr = tdatetime.strftime('%Y/%m/%d 00:00:00')
datetime1 = datetime.datetime.strptime(tstr, '%Y/%m/%d %H:%M:%S')
utc=datetime1-datetime.timedelta(hours=9)

gifu.date=utc
#gifu.date=("2014/02/20 15:00")


print "UTC:",gifu.date
#a=d.datetime()

print
sun.compute(gifu)
print "SUN DATA"
sun_rize= gifu.next_rising(sun)
#print sun_rize
t0=ephem.localtime(sun_rize)
print "sun_rize:",t0
print "az:",sun.az
sun_noon= gifu.next_transit(sun)
sun_noon_alt= sun.alt
t1=ephem.localtime(sun_noon)
print "transit :",t1
print "alt:",sun_noon_alt
sun_set= gifu.next_setting(sun)
t2=ephem.localtime(sun_set)
print "sun_set :",t2
print "az:",sun.az
day_time=t2-t0

print "\nday   :",day_time
print "night :",(datetime.timedelta(hours=24)-day_time)
print "target_day_hours:",datetime.timedelta(hours=12)
#print "last            :",datetime.timedelta(hours=12)-day_time
print "light on :",t2+datetime.timedelta(minutes=30)
print "lihgt off:",t2+datetime.timedelta(hours=12.5)-day_time

print ""

print "MOON DATA"
moon.compute(gifu)
moon_rize= gifu.next_rising(moon)
print ephem.localtime(moon_rize)
print moon.az
moon_noon= gifu.next_transit(moon)
print ephem.localtime(moon_noon)
print moon.alt
print moon.az
moon_set= gifu.next_setting(moon)
print ephem.localtime(moon_set)
print moon.az
print
#d = ephem.date(datetime.datetime.today())
today= ephem.date(datetime.datetime.today())
new_moon= ephem.previous_new_moon(today)
print "previous_new_moon"
print new_moon
print "moon_age"
print  today-new_moon
next_new_moon= ephem.next_new_moon(today)
print next_new_moon


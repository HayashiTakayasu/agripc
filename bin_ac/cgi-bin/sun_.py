# -*- coding: utf-8 -*-
import ephem
import datetime

sun=ephem.Sun()
moon=ephem.Moon()
gifu=ephem.Observer()
gifu.lon='136.751601'
gifu.lat='35.469531'
gifu.elevation=15.0
#print "now:",gifu.date

##today UTC
tdatetime = datetime.datetime.now()
tstr = tdatetime.strftime('%Y/%m/%d 00:00:00')
datetime1 = datetime.datetime.strptime(tstr, '%Y/%m/%d %H:%M:%S')
utc=datetime1-datetime.timedelta(hours=9)

gifu.date=utc
#gifu.date=("2014/02/20 15:00")


#print "UTC:",gifu.date
#a=d.datetime()

#print
sun.compute(gifu)
#print "SUN DATA"
sun_rise= gifu.next_rising(sun)
sun_rise_az=sun.az
#print sun_rize
t0=ephem.localtime(sun_rise)
sun_noon= gifu.next_transit(sun)
sun_noon_alt= sun.alt
t1=ephem.localtime(sun_noon)
sun_set= gifu.next_setting(sun)
sun_set_az=sun.az
t2=ephem.localtime(sun_set)
day_time=t2-t0

#print "last            :",datetime.timedelta(hours=12)-day_time
print u"<br/>light ON -- OFF  :,",t2+datetime.timedelta(minutes=30)
print u"  --  ",t2+datetime.timedelta(minutes=30)+datetime.timedelta(hours=13)-day_time
print u"<br/>base_lighting:,",datetime.timedelta(hours=13)
print u"<br/><br/>sunrise:,",t0,",sun_rise_az :,",sun_rise_az
print u"<br/>transit :,",t1,",alt:,",sun_noon_alt
print u"<br/>sunset :,",t2,",sun_set_az:,",sun_set_az
print u"\n<br/>daytime:,",day_time
print   u"<br/>night:,",(datetime.timedelta(hours=24)-day_time)


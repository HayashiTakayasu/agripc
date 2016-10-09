        require "agri-controller"
        include AgriController
        
        p dacs=Serial.new("W0F00000\r",dacs_port="/dev/ttyUSB0")
        dacs.time_out=1
        dacs.set
        res=dacs.serial
         p res

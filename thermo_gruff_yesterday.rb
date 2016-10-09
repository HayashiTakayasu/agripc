#coding:utf-8
require "./thermo_gruff2"
  include AgriController
  #p Dir.pwd
    p yesterday=`ruby yesterday_guess.rb`.chomp
    input_csv_data="./thermo_data/thermo_data2.csv"+"."+yesterday
    output_filename="./thermo_data/thermo_data_yesterday.jpg"
      if File.readable?(input_csv_data)
       # thermo_gruff(output_filename="thermo_data_yesterday.jpg",input_csv_data)
        #thermo_gruff2(output_filename="./thermo_data/thermo_data_yesterday.jpg",input_csv_data,range=[1.0,1.0/3,1.0/250],legend=["C","%(1/3)","CO2(1/250)"],"640x540")
        #thermo_gruff2(output_filename,input_csv_data, range=[1.0,1.0/3,1.0/100],legend=["温度℃","湿度%(1/3)","CO2濃度ppm(1/100)"],view="640x540")
        #thermo_gruff2(output_filename,input_csv_data,range=[1.0,1.0/3,1.0/100,1.0,1.0,1.0],legend=["温度℃","湿度%(1/3)","CO2濃度ppm(1/100)","飽差g/m³","露点℃","重量絶対湿度g/m³"],view="640x540")
        #thermo_gruff2(output_filename,input_csv_data,range=[1.0,1.0/3,1.0/100,1.0,1.0],legend=["温度℃","湿度%(1/3)","CO2濃度ppm(1/100)","飽差g/m³","温度℃"],view="640x540")
        thermo_gruff2(output_filename,input_csv_data,
[1.0,1.0/3,1.0/100,1.0,1.0,1.0,nil,nil,nil,nil,nil,nil,nil,nil],
legend=["温度℃","湿度%(1/3)","CO2濃度ppm(1/100)","飽差g/m³","温度2℃","温度(1)℃","湿度%(1/3)","飽差g/m³","温度(2)℃","湿度%(1/3)","飽差g/m³","温度(3)℃","湿度%(1/3)","飽差g/m³"],
view="640x540")
        #p Time.now
      end


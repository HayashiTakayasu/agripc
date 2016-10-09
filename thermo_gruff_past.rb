#coding:utf-8
require "./thermo_gruff2"
  include AgriController

  list=Dir.glob('./thermo_data/thermo_data2.txt.'+"*")-Dir.glob('./thermo_data/thermo_data2.txt.*format'+"*")-Dir.glob('./thermo_data/thermo_data2.txt.'+"*{jpg,png}")

  list.each do |input_csv_data|
    output_filename=input_csv_data+".jpg"
    if !(input_csv_data.include?(".jpg")) && File.readable?(input_csv_data) && !File.exist?(output_filename)
      p input_csv_data
      #thermo_gruff2(output_filename,input_csv_data,range=range=[1.0,1.0/3,1.0/100,1.0,1.0],legend=["温度℃","湿度%(1/3)","CO2濃度ppm(1/100)","飽差g/m³","温度℃"],view="640x540")
      thermo_gruff2(output_filename,input_csv_data,
[1.0,1.0/3,1.0/100,1.0,1.0,1.0,nil,nil,nil,nil,nil,nil,nil,nil],
legend=["温度℃","湿度%(1/3)","CO2濃度ppm(1/100)","飽差g/m³","温度2℃","温度(1)℃","湿度%(1/3)","飽差g/m³","温度(2)℃","湿度%(1/3)","飽差g/m³","温度(3)℃","湿度%(1/3)","飽差g/m³"],
view="640x540")
    end
  end

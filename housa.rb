#coding=utf-8

=begin
#Difference in the amount of Saturation Water vapor
飽和水蒸気量差（ある温度と湿度での、湿度１００％と現在の水蒸気量の差）
飽差の計算
t＝t　[℃]
rh=rh[%]

飽和水蒸気量（ほうわすいじょうきりょう）a(T)[g/m3] は1m3の空間に存在できる水蒸気の質量をgで表したものである。容積絶対湿度、飽和水蒸気密度ともいう。これは温度T[℃]が小さいと小さくなる。
水蒸気を理想気体と見なすとa(T)は以下の式で示される。

    a(T)={{217 * e(T)} \{T+273.15}}

湿度RH[％]は、その温度の飽和水蒸気量に対して、水蒸気量（絶対湿度）との比であらわす。
飽和水蒸気圧曲線、沸点で大気圧になる。
空気中の飽和水蒸気圧e(T)は気温できまり、この値を超える分圧を有する水蒸気は安定して存在できない。
e(T)は近似的にTetens(1930)のパラメータ値によるAugust他の式

    e(T)=6.1078\times 10^{7.5T\over(T+237.3)}

により、指定した温度 T[℃]における飽和水蒸気圧 e(T)[hPa]が求まる。気体の状態方程式により、水蒸気量を計算できる。

臨界圧（＝22.12MPa）まで、良い近似で求めるには、ワグナー（Wagner）式を用い、

    P_{ws} = P_c \times \exp ( \dfrac{A \times x+B \times x^{1.5} + C\times x^3 + D \times x^6}{1-x})

ここで、

    P_{ws}[kPa]ワグナーの厳密水蒸気圧
    P_c = 22120 [kPa]臨界圧
    T_c = 647.3 [K]臨界温度
    T絶対温度[K](T[K] = T[℃]+273.15)
    x = 1 - \dfrac{T}{T_c}
    A = -7.76451
    B = 1.45838
    C = -2.7758
    D = -1.23303 
    
    
 t=20
 => 20 
ruby-1.9.3-head :033 > aT=(217*eT)/(t+273.15)
 => 9.089291190842173 
ruby-1.9.3-head :034 > eT2=221200*Math::E**((-7.76451*x+1.45838*(x**1.5)-2.7758*(x**3)-1.23303*(x**6))/(1-x))
 => 12.289582804524482 
ruby-1.9.3-head :035 > 
ruby-1.9.3-head :036 >   x=1-(273.15+t)/647.3 => 0.5471188011741078 
ruby-1.9.3-head :037 > eT=6.1078*10**(7.5*t/(t+237.3))
 => 23.380935143417695 
ruby-1.9.3-head :038 > aT=(217*eT)/(t+273.15) => 17.307395279282414 
ruby-1.9.3-head :039 > x=1-(273.15+t)/647.3
 => 0.5471188011741078 
ruby-1.9.3-head :040 > eT2=221200*Math::E**((-7.76451*x+1.45838*(x**1.5)-2.7758*(x**3)-1.23303*(x**6))/(1-x))
 => 23.406201212631604 
ruby-1.9.3-head :041 > aT=(217*eT2)/(t+273.15)
 => 17.32609811748613 
==end


=end

#return hPa
#houwa_pressure(Celsius_Degree)
def houwa_pressure(t)
  eT=6.1078*10**(7.5*t/(t+237.3))
end

#return hPa(Pa * 100)
def houwa_pressure2(t)
  x=1-(273.15+t)/647.3
  eT2=221200*Math::E**((-7.76451*x+1.45838*(x**1.5)-2.7758*(x**3)-1.23303*(x**6))/(1-x))
end


#houwa(Celsius_Degree) # =>g/m^3
def houwa(t)
 eT=houwa_pressure(t)
 #et=houwa_pressure2(t)
 aT=(217*eT)/(t+273.15)
end

def houwa2(t)
 #et=houwa_pressure(t)
 eT=houwa_pressure2(t)
 aT=(217*eT)/(t+273.15)
end

#housa(Celsius_degree,Rh(%)) # =>g/m^3
def housa(t,rh)
  x=houwa(t)
  x2=x*rh/100.0
  x-x2
end


def housa2(t,rh)
  x=houwa2(t)
  x2=x*rh/100.0
  x-x2 
end

#roten(Celsius_degree,Rh(%)) # =>Celsius_Degree
def roten(t,rh)
  ps=houwa_pressure(t)*100
  e =ps*rh/100.0
  y=Math.log(e/611.213)
  if y>=0
    p "1"
    td=13.715*y+8.4262*0.1*y**2+1.9048*0.01*y**3+7.8158*0.001*y**4
  elsif y<0
    p "2"
    td2=13.7204*y+7.36631*0.1*y**2+3.32136*0.01*y**3+7.78591*0.001*y**4
  else
    p "3"
    0
  end
end

#
def zettai(t,rh)
  x=houwa(t)
  x2=x*rh/100.0
end

if $0==__FILE__
  #require "profile"
  begin
    #p "[t(℃),rh(%)]="+[ARGV[0],ARGV[1]].inspect
    print housa(ARGV[0].to_f,ARGV[1].to_f).to_s+"\n"
  rescue
    #50.times do
    puts "ruby ./housa.rb [Celsius Degree] [rh%]=> g/m^3"
    puts "ruby ./housa.rb 25 60 # =>#{housa(25,60)}"
    puts
    p "25 C 60%"
    p housa(25,60)
    p housa2(25,60)
    p "25 C,70%"
    p housa(25,70)
    p housa2(25,70)
    p "25 C,80%"
    p housa(25,80)
    p housa2(25,80) 
    #end
    p roten(25,80)
    p zettai(25,80)
  end
end

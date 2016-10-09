#!ruby

require "rubygems"
require "agri-controller"
include AgriController

p thermo_read("http://192.168.0.4/cgi-bin/thermo.rb")
  require "open-uri"
      ref="http://192.168.0.4/cgi-bin/thermo.rb"
      uri=URI(ref)
      dat=uri.read("Accept-Language" => "ja")
      p dat


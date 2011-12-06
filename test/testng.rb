require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "../lib/tasks/terms_de_en.htm"
url2 = "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Anhry-cpGvzYdGRNMEtyWVphaEZQVGN3bWMxaF9aU0E&output=html"
#later use file upload or GoogleDocs..


#create NG document
# doc = Nokogiri::HTML(open(url))
# puts doc.at_css("table").text  

doc = Nokogiri::HTML(open(url2))
source_lang = doc.at_css(".s0").text 
target_lang = doc.at_css(".s1").text
puts source_lang
puts target_lang



# puts doc.css("tr:nth-child(3) td")
#headers :nth-child(3), .s0
# sourcelang .s0, targetlang .s1
# puts doc.css(".s0") 
doc.css("tr td").each do |item|
 puts item.text
end
  #tr:nth-child(10) td
 

#now try with XML TMX
doctmx = "AUDI_ALTA_ENUS.tmx"
mem = Nokogiri::XML(open(doctmx))

#get the languages

segs = Array.new
#split pair by pair
mem.xpath("//tuv[@xml:lang='DE-DE' or @xml:lang='EN-US']/seg").each do |i|
  str = i.content
  str = str.chomp
  # gsub(/[]/, '')
  segs.push(str)
end

segs.each do |s|
  puts s
end

require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "../lib/tasks/terms_de_en.htm"
url2 = "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Anhry-cpGvzYdGRNMEtyWVphaEZQVGN3bWMxaF9aU0E&output=html"
#later use file upload or GoogleDocs..


#create NG document
doc = Nokogiri::HTML(open(url))
puts doc.at_css("table").text  

doc = Nokogiri::HTML(open(url2))
puts doc.at_css("title").text 

#headers :nth-child(3), .s0
# sourcelang .s0, targetlang .s1
puts doc.css(".s0") 
doc.css("tr td").each do |item|
  puts item.text
end
 #tr:nth-child(10) td
 


require 'rubygems'
require 'nokogiri'
require 'open-uri'

url = "../lib/tasks/terms_de_en.htm"
url2 = "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Anhry-cpGvzYdGRNMEtyWVphaEZQVGN3bWMxaF9aU0E&output=html"
#later use file upload or GoogleDocs..


#create NG document
# doc = Nokogiri::HTML(open(url))
# puts doc.at_css("table").text  

# doc = Nokogiri::HTML(open(url2))
# source_lang = doc.at_css(".s0").text 
# target_lang = doc.at_css(".s1").text
# puts source_lang
# puts target_lang



# puts doc.css("tr:nth-child(3) td")
#headers :nth-child(3), .s0
# sourcelang .s0, targetlang .s1
# puts doc.css(".s0") 
# doc.css("tr td").each do |item|
#  puts item.text
# end
  #tr:nth-child(10) td
 

#TMX
#pass 1 

#EUROSCRIPT

#get file

doctmx = "AUDI_ALTA_ENUS.tmx"
eurotmx = "8796_EUROS.tmx"

#bind to names
# mem1 = Nokogiri::XML(open(doctmx))
begin
  mem = Nokogiri::XML(open(eurotmx))
rescue
  puts "Error: nothing doing"
end




#get the languages
langs = mem.xpath('//tu/tuv/@xml:lang')
sourcelang, targetlang = langs[0], langs[1]

#domain, name will be added at file import

#any propos? get props


#set up dictionary

#parse segments

#check for junk
#what do we need to remove?
# 'hello'.gsub(/[eo]/, 'e' => 3, 'o' => '*')    #=> "h3ll*"
removetags2 = /(<.*>)/, 'XXX'
#first remove inner tags
removetags = "/[<.?>]/, '<.*>' => '****'"


# TODO:
# Clean up DE strings 


encoding = Encoding::UTF_8
isTerm= false
rootid = eurotmx + "_"
segcounter= 0 
xpathsrc = "//tu/tuv[@xml:lang='" + sourcelang + "']/seg"
xpathtar = "//tu/tuv[@xml:lang='" + targetlang + "']/seg"
mem.xpath(xpathsrc).each do |seg|
    segment = seg.text.chomp.force_encoding(encoding)
    # removes chars within tags, returns array of 'words'
    # removes bad chars, removes some common tag words, returns string
    #this works for EN
    # segment = segment.scan(/\w+(?!=>)/).find_all{|item| item =~ /[^(ph)|(lt)|(hs)|(gt)]/ }.join(" ")
    #make this work for DE, also match äöüÄÖÜß how?    
    segment = segment.scan(/\S+(?!=>)/).find_all{|item| item =~ /[^(ph)|(lt)|(hs)|(gt)|(:af)|(:hr)]/ }.join(" ")
    puts segment, sourcelang, rootid+segcounter.to_s
    segcounter = segcounter+1
end

# mem.xpath(xpathtar).each do |tar|
#     do something with tar.text, targetlang
# end


# segs = Array.new
# #split pair by pair
# mem.xpath("//tuv[@xml:lang='DE-DE' or @xml:lang='EN-US']/seg").each do |i|
#   str = i.content
#   str = str.chomp
#   # gsub(/[]/, '')
#   segs.push(str)
# end
# 
# segs.each do |s|
#   puts s
# end

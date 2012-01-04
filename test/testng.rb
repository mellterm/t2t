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
 
# TODO: enforce encoding
# TODO: What about properties? Pass#1 ignore props 

#have a list of memories, create repos..then fill
doctmx = "AUDI_ALTA_ENUS.tmx"
interimtxm = "memory_interim_122911_0954UCT.tmx"


eurotmx = "8796_EUROS.tmx"

def importtmx(filename)
  f = File.open(filename)
  # representation of whole document
  doc = Nokogiri::XML.parse(f)
  
  #get the languages
  langs = doc.xpath('//tu/tuv/@xml:lang')
  sourcelang, targetlang = langs[0], langs[1]
  
  
  #create a Repo
  
  
  
  #get the segments 
  
  #source language
  xpathsrc = "//tu/tuv[@xml:lang='" + sourcelang + "']/seg"
  source_count = 0
  translations = {}
  doc.xpath(xpathsrc).each do |seg|
    source_count = source_count+1
    segid = "#{source_count}"
    seg= seg.children.reject {|x| x.element?}.join {|x| x.content}.squeeze(" ").strip
    # create Translation object
  end

  
  
  target language
  xpathtar = "//tu/tuv[@xml:lang='" + targetlang + "']/seg"
  target_count = 0
  doc.xpath(xpathtar).each do |seg|
      target_count = target_count+1
      segid= "#{target_count}"
      seg= seg.children.reject {|x| x.element?}.join {|x| x.content}.squeeze(" ").strip
  
    end
  
  #every document has metadata added on File Upload page
  # name, url, expires_on, source_language, domains 
  
  #every translation has the following data:
  # Table name: translations
  #
  #  id                 :integer         not null, primary key
  #  source_content     :string(255)     not null
  #  source_language_id :integer         not null
  #  target_content     :string(255)     not null
  #  target_language_id :integer         not null
  #  repo_id            :integer         not null
  #  isPublic           :boolean         default(TRUE)
  #  created_at         :datetime
  #  updated_at         :datetime
  #  created_by_id      :integer
  #  last_updated_by    :integer
  #  isTerm             :boolean         default(TRUE)
  #

  current_user = 1
  created_by_id = current_user
  source_language_id = Language.find_by_id(sourcelang)
  target_language_id = Language.find_by_id(targetlang)
  isPublic = true
  created_at = Time.now
  isTerm= false
  #create translations
  #join based on segment id
  
  
 
 
  rootid = eurotmx + "_"
  # used for identifying segments







#domain, name will be added at file import

#any propos? get props

end





def oldparseTMX()
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

        puts segment, sourcelang, rootid+segcounter.to_s
        segcounter = segcounter+1
    end
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

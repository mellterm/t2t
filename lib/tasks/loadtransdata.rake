desc "Import translation data"
task :import_translation_data  => :environment do
  
  require 'nokogiri'
  require 'open-uri'
  # spreadsheet data used to seed, also for dataimport function
  
  #  source_content     :string(255)     not null
  #  source_language_id :integer         not null
  #  target_content     :string(255)     not null
  #  target_language_id :integer         not null
  #  repo_id            :integer         not null
  #  isPublic           :boolean         default(TRUE)
  
  
 #source language find id got name
  
  Translation.delete_all
  
  url2 = "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Anhry-cpGvzYdGRNMEtyWVphaEZQVGN3bWMxaF9aU0E&single=true&gid=0&output=html"
  doctype = 'term'
  @doc = Nokogiri::HTML(open(url2), 'UTF-8')
  headerinfo = @doc.at_css("html body div[2] table tr[2]")
  source_language = headerinfo.at_css("td[2]").content
  source_languge_id = Language.find_by_ISOcode(source_language.downcase).id
  target_language = headerinfo.at_css("td[3]").content
  target_language_id = Language.find_by_ISOcode(target_language.downcase).id
  
  #create repo then create translation thru repo
  
  
  #not tr, tr[1], tr[2]
  nodecount = 0
  rows = @doc.css("html body div[2] table tr")
    translationscount = rows.collect do |node|
      
      srcnode = node.at_css("td[2]").content
      tarnode =  node.at_css("td[3]").content
      isPublic = node.at_css("td[4]").content.downcase
      unless nodecount ==1 || srcnode.blank? || tarnode.blank?
        #takes out language info which is in same (the first) td
        Translation.create!(
          :source_content => srcnode,
          :target_content => tarnode,
          :isPublic => isPublic,
          :source_language_id => source_languge_id,
          :target_language_id => target_language_id,
          :repo_id => 1
        )
      end
      #TODO: filter out blanks
    
    
    
    
      # detail = {}
      # #filter out first three
      # unless [0,1,2].include?(nodecount)
      #   [
      #     [:source_content, 'td[2]'.content],
      #     [:target_content, 'td[3]'.content],
      #     [:isPublic, 'td[4]'.content]
      #     ].collect do |obj, css|
      #   detail[obj] = node.at_css(css).to_s.strip
   
    nodecount= nodecount+1  
    end
    puts translationscount.count 
end
   

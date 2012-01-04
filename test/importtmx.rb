def import_tmx(file, docdomains)
   require 'rufus/mnemo'
   require 'nokogiri'
   require 'open-uri'
   
   
   current_user_id = 51
   # timenow = Time.now
   #  created_at = timenow
   #  expires_on = timenow + 30.days
   #  isPublic = true

   #open file, get language info
   f = File.open(file)
   # representation of whole document
   doc = Nokogiri::XML.parse(f)  
   #get the languages
   langs = doc.xpath('//tu/tuv/@xml:lang')
   source_language, target_language = langs[0].value.sub(/-/, "_").downcase, langs[1].value.sub(/-/, "_").downcase
   source_language_id = Language.find_by_ISOcode(source_language).id
   target_language_id = Language.find_by_ISOcode(target_language).id
   # use parent id as default
   # source_parent_lang, target_parent_lang = langs[0].value.match(/(.*)[-_].*/)[0].downcase, langs[1].value.match(/(.*)[-_].*/)[0].downcase
   puts source_language_id
   #domains will be input via form
 
   listdomainids = []
   Domain.find_all_by_code([docdomains]).each do |d|
     listdomainids.push(d.id)
   end
  
  
  
  
  
end

interimtmx = "memory_interim_122911_0954UCT.tmx"
import_tmx(interimtmx, ["MECHENG"])
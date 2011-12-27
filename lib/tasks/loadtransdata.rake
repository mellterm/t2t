desc "Import translation data"
task :import_translation_data  => :environment do
# run via $ rake import_translation_data  
  require 'nokogiri'
  require 'open-uri'

  clean_up_database
  create_source_doc_from_TMX
  create_term_list_from_Gdocs

end  

def clean_up_database
  Translation.delete_all
  TranslationDomain.delete_all
end  


def create_source_doc_from_TMX
  # used for generating (access) token
  # TODO: RUN Task on 10-15 memories, use code on translate! page, display segments as Jquery table for repo.
 require 'rufus/mnemo'
  
  eurotmx = "#{RAILS_ROOT}/test/8796_EUROS.tmx"
  current_user_id = 1
  now = Time.now
  created_at = now
  expires_on = now + 30.days
  isPublic = true
  
  #open file, get language info
  f = File.open(eurotmx)
  # representation of whole document
  doc = Nokogiri::XML.parse(f)  
  #get the languages
  langs = doc.xpath('//tu/tuv/@xml:lang')
  source_language, target_language = langs[0].value.sub(/-/, "_").downcase, langs[1].value.sub(/-/, "_").downcase
  source_language_id = Language.find_by_ISOcode(source_language).id
  target_language_id = Language.find_by_ISOcode(target_language).id
  # use parent id as default
  # source_parent_lang, target_parent_lang = langs[0].value.match(/(.*)[-_].*/)[0].downcase, langs[1].value.match(/(.*)[-_].*/)[0].downcase
  
  #domains will be input via form
  docdomains = ["MECHENG", "ELECENG"]
  listdomainids = []
  Domain.find_all_by_code([docdomains]).each do |d|
    listdomainids.push(d.id)
  end
  

  #create memory<repo
  #TODO: Memory like Repo but no content
  #TODO: Make sure Languages contains all possible ISOcodes  
  mem = Memory.create!(
  :name => eurotmx,
  :owner_id => 1,
  :created_at => created_at,
  :expires_on => expires_on,
  :source_language_id => source_language_id,
  :target_language_id => target_language_id, 
  :token => Rufus::Mnemo::from_integer(rand(8**5))
  )
  
  segcount = 0
  segs = []
  #get string pairs
  doc.xpath("//tu/tuv/seg").each do |seg|
    #FILO segs
    segs.push(seg.children.reject {|x| x.element?}.join {|x| x.content}.squeeze(" ").strip)
    if segs.size == 2
      #time to create Translation
      trans = Translation.create!(
        :target_content => segs.pop,
        :source_content => segs.pop,
        :source_language_id => source_language_id,
        :target_language_id => target_language_id,
        :repo_id => mem.id,
        :isPublic => isPublic,
        :created_at => now,
        :created_by_id => current_user_id,
        :isTerm => false
      )
      listdomainids.each do |d|
            TranslationDomain.create!(:translation_id => trans.id, :domain_id => d)
      end  
    end
  end 
end

def create_term_list_from_Gdocs

  # == Schema Information
  #
  # Table name: repos
  #
  #  id                 :integer         not null, primary key
  #  name               :string(255)
  #  owner_id           :integer
  #  created_at         :datetime
  #  updated_at         :datetime
  #  type               :string(255)
  #  expires_on         :datetime
  #  url                :string(255)
  #  source_language_id :integer
  #  target_language_id :integer
  #  content            :text
  #  token              :string(255)

  #srcdoc is a kind of repo with added fields
  srcdoc_meta = { 
    :source_language_id => Language.find_by_ISOcode("de-de"), 
    :domains => ["MECHENG", "ELECTRICAL" ],
    :liveurl => "https://docs.google.com/document/pub?id=1Hcd4XO-JBAZ_3xkdwRnAsVwBkbbHeT6gzefAspygtb0",
    :expires_on => Date.today + 1.month
       
       }
  
  
  
  url2 = "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Anhry-cpGvzYdGRNMEtyWVphaEZQVGN3bWMxaF9aU0E&single=true&gid=0&output=html"  
  @doc = Nokogiri::HTML(open(url2), 'UTF-8')
  headerinfo = @doc.at_css("html body div[2] table tr[2]")
  source_language = headerinfo.at_css("td[2]").content
  source_languge_id = Language.find_by_ISOcode(source_language.downcase).id
  target_language = headerinfo.at_css("td[3]").content
  target_language_id = Language.find_by_ISOcode(target_language.downcase).id
  
  #create repo then create translation thru repo
  @repos = Repo.all
  
  #not tr, tr[1], tr[2]
  nodecount = 0
  rows = @doc.css("html body div[2] table tr")
    translationscount = rows.collect do |node|
      
      srcnode = node.at_css("td[2]").content
      tarnode =  node.at_css("td[3]").content
      isPublic = node.at_css("td[4]").content.downcase
      user_id = User.all.sort_by{ rand }.slice(0).id
      unless nodecount ==1 || srcnode.blank? || tarnode.blank?
        #takes out language info which is in same (the first) td
        @repos.each do |repo|
            trans = Translation.create!(
              :source_content => srcnode,
              :target_content => tarnode,
              :isPublic => isPublic,
              :source_language_id => source_languge_id,
              :target_language_id => target_language_id,
              :repo_id => repo.id,
              :created_by_id => user_id,
              :isTerm => true
            )
            #create translation domain pairs for global list domains
            #TODO: add extra column like isPublic for extra domains
            listdomains_url2 = ["TECHDOCU", "ELECENG"]
            listdomainids = []
            Domain.find_all_by_code([listdomains_url2]).each do |d|
              listdomainids.push(d.id)
            end
            
            listdomainids.each do |d|
              TranslationDomain.create!(:translation_id => trans.id, :domain_id => d)
            end
        end
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
   
   
   

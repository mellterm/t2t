desc "Import translation data"
task :import_translation_data  => :environment do
# run via $ rake import_translation_data  
  require 'nokogiri'
  require 'open-uri'
  
  # spreadsheet data used to seed, also for dataimport function
  
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
  

  Translation.delete_all
  TranslationDomain.delete_all
  
  #represent all documents as a repo...
  
  # Table name: repos
  #
  #  id         :integer         not null, primary key
  #  name       :string(255)
  #  owner_id   :integer
  #  created_at :datetime
  #  updated_at :datetime
  #

  #srcdoc is a kind of repo with added fields...expires_on will be in repo.
  srcdoc_meta = { 
    :source_language_id => Language.find_by_ISOcode("de-de"), 
    :domains => ["MECHENG", "ELECTRICAL" ],
    :liveurl => "https://docs.google.com/document/pub?id=1Hcd4XO-JBAZ_3xkdwRnAsVwBkbbHeT6gzefAspygtb0",
    :expires_on => Date.today + 1.month
       
       }
  
  
  
  url2 = "https://docs.google.com/spreadsheet/pub?hl=en_US&hl=en_US&key=0Anhry-cpGvzYdGRNMEtyWVphaEZQVGN3bWMxaF9aU0E&single=true&gid=0&output=html"
  

  
  def processGSourceDoc(url)
    f = File.open(url)
    begin
      
      
      
      
    rescue
      puts "cannot open file, #{msg}"
      
    ensure
      f.close    
    end
    
  end
  
  
  
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
   

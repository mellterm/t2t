# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#run rake db:seed



require 'active_record/fixtures'
Language.delete_all
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "languages")
Domain.delete_all
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "domains")
DomainI18n.delete_all
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "domain_i18ns")
LanguageI18n.delete_all
Fixtures.create_fixtures("#{Rails.root}/db/fixtures", "language_i18ns")

#put term translation in afile 


#this will form the basis of the load file module for TXT terms (CSV?) and TMX
#first try and enter terms on the fly

 

#need to load in data separately for each language
#act simultaneously as source and target
Translation.delete_all

  repo_ids = Repo.all.map &:id
  repo_id_size = repo_ids.count
  isPublic = rand(0)>0.5 ? true : false
  repoID = rand(repo_id_size)
  created_at =  2.days.ago..Time.now

# domains are MECHENG 7, some TECHDOCU 3 
# File.open(RAILS_ROOT + "/lib/tasks/testData_deen.txt").each { |line|
#   line = line.chomp
#   line = line.split("|")
#   @translation = Translation.create!(:source_content => line[0], :target_content => line[1], 
#                                   :source_language_id => 1, :target_language_id => 4,
#                                   :repo_id => repoID, :created_at => created_at, :isPublic => isPublic)
#   @translation.domains.create!(:id => 7)
# }
# File.open(RAILS_ROOT + "/lib/tasks/testData_dees.txt").each { |line|
#    line = line.chomp
#     line = line.split("|")
#     @translation = Translation.create!(:source_content => line[0], :target_content => line[1], 
#                                     :source_language_id => 1, :target_language_id => 7,
#                                     :repo_id => repoID, :created_at => created_at, :isPublic => isPublic)
#     @translation.domains.create!(:id => 7)
#   }




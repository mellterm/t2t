namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
	  require 'ffaker'
	  #clears existing database content for tables to be populated
	  #domain, language are separately seeded, as is translation
	  [User, Repo, Role].each(&:delete_all)
		Rake::Task['db:reset'].invoke
		make_users
		make_repos
		make_roles
  end
end		


def make_users
  #make 50 users
  # Table name: users
  #
  #  id            :integer         not null, primary key
  #  email         :string(255)
  #  password_hash :string(255)
  #  password_salt :string(255)
  #  created_at    :datetime
  #  updated_at    :datetime
  #  language_id   :integer
  #  name          :string(255)
  #  pitch         :string(255)
  #  website       :string(255)
  #  timezone      :string(255)
  #
  
  @languages = Language.all
  @users = User.all
  
  50.times do |n|
		email = Faker::Internet.email
		name = Faker::Name.first_name
		password = "foobar"
    created_at =  5.days.ago..Time.now
    lang = @languages.sort_by{ rand }.slice(0).id
    pitch = Faker::Lorem.paragraph
    website = "http://www." + Faker::Internet.domain_name
    timezone = ActiveSupport::TimeZone.all.sort_by { rand }.slice(0).formatted_offset
    User.create!(
    :name => name,
    :email => email,
    :password => password,
    :password_confirmation => password,
    :language_id => lang,
    :pitch => pitch,
    :website => website,
    :timezone => timezone
    )
  end
end


def make_repos 
  #make 10 repos
  10.times do |p|
    name = Faker::Company.name
    owner_id = 1+rand(50)
    created_at = 2.months.ago..Time.now
    
    Repo.create!(
    :name => name,
    :owner_id => owner_id,
    :created_at => created_at
    )
    	
  end
  
def make_roles
  #make the 5 roles
  ["Translator", "Reviewer", "Guest", "Endclient", "Client"].each do |name|
    Role.create!(:name => name)
  end
end   

end
  
    

# def make_languages
#   
#   Language.delete_all
#   ["en" =>"English", "de" => "German", "ru" => "Russian", "zh" => "Chinese", "es" => "Spanish", "en-us" =>"English, US", "en-gb" => "English, GB", "en-ca" => "English, Canada", "de-de" => "German, Germany", "de-at" => "German, Austria", "de-ch" => "German, Swiss", 
#     "ru-ru" => "Russian, Russia", "zh-zh" => "Chinese, Mainland"].each do |code, name|
#     Language.create!(:ISOcode => code, :name => name)
#   end
# end
namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do
	  #clears existing database content for tables to be populated
	  #domain, language are separately seeded
	  [User, Repo, Translation].each(&:delete_all)
    Translation.delete_all
	  [User, Repo].each(&:delete_all)
		Rake::Task['db:reset'].invoke
		make_users
		make_repos
  end
end		


def make_users
  #make 50 users
  50.times do |n|
		email = Faker::Internet.email
		password = "foobar"
    created_at =  5.days.ago..Time.now
    
    User.create!(
    :email => email,
    :password => password,
    :password_confirmation => password
    )
  end
end


def make_repos 
  #make 10 repos
  10.times do |p|
    name = Faker::Company.name
    owner_id = 1+rand(50)
    created_at = 5.months.ago..Time.now
    
    Repo.create!(
    :name => name,
    :owner_id => owner_id,
    :created_at => created_at
    )
    	
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
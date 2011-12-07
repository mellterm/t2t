class Translation < ActiveRecord::Base
  attr_accessible :isPublic, :source_content, :target_content, :repo_id, :source_language_id, :target_language_id, :isTerm, :created_by_id
  belongs_to :repo
  belongs_to :created_by, :class_name => "User"
  has_many :TranslationDomains
  has_many :domains, :through =>:TranslationDomains
  validates_presence_of :source_content, :target_content
  
  
  
      def fresh?
        now = Date.today
        self.created_at > now-5.days
      end

end  







# == Schema Information
#
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


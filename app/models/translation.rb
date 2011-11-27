class Translation < ActiveRecord::Base
  attr_accessible :isPublic, :source_unit_id, :target_unit_id, :repo_id, :source_language_id, :source_content
  belongs_to :repo
  
  has_many :TranslationDomains
  has_many :domains, :through =>:TranslationDomains
  validates_presence_of :source_content
  
  
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
#  repo_id            :integer         not null
#  isPublic           :boolean         default(TRUE)
#  created_at         :datetime
#  updated_at         :datetime
#  source_content     :string(255)
#  source_language_id :integer
#  target_content     :string(255)
#  target_language_id :integer
#


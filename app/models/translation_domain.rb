class TranslationDomain < ActiveRecord::Base
  belongs_to :translation
  belongs_to :domain
  
  #can have same translation ID as long as the domain id's are different
  validates_uniqueness_of :translation_id, :scope => :domain_id
  
  
end

# == Schema Information
#
# Table name: translation_domains
#
#  id             :integer         not null, primary key
#  translation_id :integer
#  domain_id      :integer
#  created_at     :datetime
#  updated_at     :datetime
#


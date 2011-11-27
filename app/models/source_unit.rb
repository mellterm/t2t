class SourceUnit < ActiveRecord::Base
  attr_accessible :content, :language_id
  has_many :repos
  has_many :translations
  has_many :targetUnits, :through => :translations
  
end


# == Schema Information
#
# Table name: source_units
#
#  id          :integer         not null, primary key
#  content     :string(255)
#  language_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#  repo_id     :integer
#


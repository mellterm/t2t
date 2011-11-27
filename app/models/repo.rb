class Repo < ActiveRecord::Base
  attr_accessible :name, :translations_attributes
     
  belongs_to :owner, :class_name => 'User'
  validates_presence_of :name
  
  has_many :translations, :order => 'translations.created_at DESC', :dependent => :destroy
  accepts_nested_attributes_for :translations

  default_scope :order => 'repos.name DESC'



  
end

# == Schema Information
#
# Table name: repos
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  owner_id   :integer
#  created_at :datetime
#  updated_at :datetime
#


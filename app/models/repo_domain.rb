class RepoDomain < ActiveRecord::Base
  attr_accessible :repo_id, :domain_id
  belongs_to :repo
  belongs_to :domain
  
  #can have same translation ID as long as the domain id's are different
  validates_uniqueness_of :repo_id, :scope => :domain_id
  
  
end
# == Schema Information
#
# Table name: repo_domains
#
#  id         :integer         not null, primary key
#  repo_id    :integer
#  domain_id  :integer
#  created_at :datetime
#  updated_at :datetime
#


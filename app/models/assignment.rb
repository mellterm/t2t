class Assignment < ActiveRecord::Base
  attr_accessible :role_id, :user_id, :repo_id
  belongs_to :user
  belongs_to :role
end

# == Schema Information
#
# Table name: assignments
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  role_id    :integer
#  repo_id    :integer
#  expires_on :datetime
#  created_at :datetime
#  updated_at :datetime
#


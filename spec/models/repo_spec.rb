require 'spec_helper'

describe Repo do
  pending "add some examples to (or delete) #{__FILE__}"
end


# == Schema Information
#
# Table name: repos
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  owner_id           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  type               :string(255)
#  expires_on         :datetime
#  url                :string(255)
#  source_language_id :integer
#  target_language_id :integer
#  content            :text
#  token              :string(255)
#


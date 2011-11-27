require 'spec_helper'

describe Translation do
  pending "add some examples to (or delete) #{__FILE__}"
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


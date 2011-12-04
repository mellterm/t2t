class Language < ActiveRecord::Base
  has_many :language_i18ns
  has_many :users
end



# == Schema Information
#
# Table name: languages
#
#  id        :integer         not null, primary key
#  ISOcode   :string(255)
#  name      :string(255)
#  parent_id :integer
#


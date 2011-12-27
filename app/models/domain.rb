class Domain < ActiveRecord::Base
  has_many :domain_i18ns
  
  has_many :TranslationDomains
  has_many :translations, :through =>:TranslationDomains
  
  has_many :RepoDomains
  has_many :repos, :through =>:RepoDomains
  
  
end


# == Schema Information
#
# Table name: domains
#
#  id        :integer         not null, primary key
#  code      :string(255)
#  name      :string(255)
#  parent_id :integer
#


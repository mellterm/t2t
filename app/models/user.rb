class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :name, :language_id, :pitch, :website, :timezone, :avatar_file_name
  attr_accessor :password,:preferred_language
  before_save :encrypt_password
  
  belongs_to :preferred_language, :class_name => 'Language'
  
  has_many :assignments
  has_many :roles, :through => :assignments
  
  
  has_many :repos, :foreign_key => :owner_id, :dependent => :destroy
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_length_of :password, :within => 3..8, :on => :create
  validates_presence_of :email, :on => :create, :message => I18n.t(:cant_be_blank)
  validates_uniqueness_of :email, :on => :create, :message => I18n.t(:must_be_unique), :case_sensitive => false
  validates_format_of :email, :with => email_regex, :on => :create, :message => I18n.t(:must_be_unique)
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "50x50>" }, :default_url => '/images/legomanereviewer2.jpg'
  
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    #check if passwords match
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      #returns nil if user fails authentication
      nil
    end
  end
  
  
  #using bcrypt for authentication
  
  def encrypt_password
    #present if not blank
    if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  

end


  def show
    
  end




# == Schema Information
#
# Table name: users
#
#  id                  :integer         not null, primary key
#  email               :string(255)
#  password_hash       :string(255)
#  password_salt       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  language_id         :integer
#  name                :string(255)
#  pitch               :string(255)
#  website             :string(255)
#  timezone            :string(255)
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#


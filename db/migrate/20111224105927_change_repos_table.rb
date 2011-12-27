class ChangeReposTable < ActiveRecord::Migration
  def self.up
     change_table :repos do |t|
        t.string :type
        t.datetime :expires_on
        t.string :url
        t.integer :source_language_id
        t.integer :target_language_id
        t.text :content
        t.string :token
     end 
  end

  def self.down
     change_table :repos do |t|
        t.remove :type
        t.remove :expires_on
        t.remove :url
        t.remove :source_language_id
        t.remove :target_language_id
        t.remove :content
        t.remove :token
      end
  end
end

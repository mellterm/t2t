class AddLanguageColumnToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.integer :language_id
    end
  end

  def self.down
    change_table :users do |t|
        t.remove :language_id
      end
    
  end
end

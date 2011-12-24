class UpdateUsersTable < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.string :name
      t.string :pitch
      t.string :website
      t.string :timezone
    end
  end

  def self.down
    change_table :users do |t|
      t.remove :name
      t.remove :pitch
      t.remove :website
      t.remove :timezone
      end 
  end
end

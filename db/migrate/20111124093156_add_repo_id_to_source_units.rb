class AddRepoIdToSourceUnits < ActiveRecord::Migration
  def self.up
    change_table :source_units do |t|
      t.integer :repo_id
      
    end  
  end

  def self.down
    change_table :source_units do |t|
    t.remove :repo_id
  end
end
end

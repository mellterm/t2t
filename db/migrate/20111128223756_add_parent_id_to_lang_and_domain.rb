class AddParentIdToLangAndDomain < ActiveRecord::Migration
  def self.up
     change_table :languages do |t|
        t.integer :parent_id
      end
      
      change_table :domains do |t|
        t.integer :parent_id
      end
  end

  def self.down
    change_table :languages do |t|
        t.remove :parent_id
      end
    change_table :domains do |t|
        t.remove :parent_id
      end   
  end
end

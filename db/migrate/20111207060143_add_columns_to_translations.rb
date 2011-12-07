class AddColumnsToTranslations < ActiveRecord::Migration
  def self.up
     change_table :translations do |t|
        t.integer :created_by_id
        t.integer :last_updated_by
        t.boolean :isTerm, :default => true
    end
  end

  def self.down
     change_table :translations do |t|
        t.remove :created_by_id
        t.remove :last_updated_by 
        t.remove :isTerm
      end
  end
end

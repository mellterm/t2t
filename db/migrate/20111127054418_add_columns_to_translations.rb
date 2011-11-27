class AddColumnsToTranslations < ActiveRecord::Migration
  def self.up
    change_table :translations do |t|
      t.remove :source_unit_id, :target_unit_id
      t.string :source_content
      t.integer :source_language_id
      t.string :target_content
      t.integer :target_language_id
    end
    add_index :translations, :source_content
    add_index :translations, :target_content
    drop_table :source_units, :target_units
  end

  def self.down
      change_table :translations do |t|
        t.remove :source_content, :source_language_id, :target_content, :target_language_id 
      end
end
end

class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.string :source_content, :null => false
      t.integer :source_language_id, :null => false
      t.string :target_content, :null => false
      t.integer :target_language_id, :null => false
      t.integer :repo_id, :null => false
      t.boolean :isPublic, :default => true
      t.timestamps
    end
      add_index :translations, :source_content
      add_index :translations, :target_content
  end

  def self.down
    drop_table :translations 
  end
end

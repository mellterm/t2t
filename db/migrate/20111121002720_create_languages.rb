class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :ISOcode
      t.string :name
    end
  end

  def self.down
    drop_table :languages
  end
end

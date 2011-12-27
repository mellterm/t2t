class CreateRepoDomains < ActiveRecord::Migration
  def self.up
    create_table :repo_domains do |t|
      t.integer :repo_id
      t.integer :domain_id
      t.timestamps
    end
  end

  def self.down
    drop_table :repo_domains
  end
end

# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111128211729) do

  create_table "domain_i18ns", :force => true do |t|
    t.integer "domain_id"
    t.integer "language_id"
    t.string  "name"
  end

  create_table "domains", :force => true do |t|
    t.string "code"
    t.string "name"
  end

  create_table "language_i18ns", :force => true do |t|
    t.integer "language_id"
    t.integer "reflanguage_id"
    t.string  "name"
  end

  create_table "languages", :force => true do |t|
    t.string "ISOcode"
    t.string "name"
  end

  create_table "repos", :force => true do |t|
    t.string   "name"
    t.integer  "owner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "repos", ["owner_id"], :name => "index_repos_on_owner_id"

  create_table "target_units", :force => true do |t|
    t.string   "content"
    t.integer  "language_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "repo_id"
  end

  add_index "target_units", ["content"], :name => "index_target_units_on_content"

  create_table "translation_domains", :force => true do |t|
    t.integer  "translation_id"
    t.integer  "domain_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", :force => true do |t|
    t.integer  "repo_id",                              :null => false
    t.boolean  "isPublic",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "source_content"
    t.integer  "source_language_id"
    t.string   "target_content"
    t.integer  "target_language_id"
  end

  add_index "translations", ["source_content"], :name => "index_translations_on_source_content"
  add_index "translations", ["target_content"], :name => "index_translations_on_target_content"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "language_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end

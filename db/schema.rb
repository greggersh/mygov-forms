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

ActiveRecord::Schema.define(:version => 20121128155426) do

  create_table "agencies", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "form_fields", :force => true do |t|
    t.string   "name"
    t.string   "field_type"
    t.integer  "form_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "label"
    t.text     "description"
    t.boolean  "is_required", :default => false
    t.text     "options"
    t.boolean  "multiple",    :default => false
  end

  add_index "form_fields", ["form_id"], :name => "index_form_fields_on_form_id"

  create_table "forms", :force => true do |t|
    t.string   "title"
    t.string   "number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pdf_fields", :force => true do |t|
    t.string   "name"
    t.integer  "x"
    t.integer  "y"
    t.integer  "page_number"
    t.integer  "pdf_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "form_field_id"
  end

  add_index "pdf_fields", ["form_field_id"], :name => "index_pdf_fields_on_form_field_id"
  add_index "pdf_fields", ["pdf_id"], :name => "index_pdf_fields_on_pdf_id"

  create_table "pdfs", :force => true do |t|
    t.string   "url"
    t.integer  "form_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "pdfs", ["form_id"], :name => "index_pdfs_on_form_id"

  create_table "submissions", :force => true do |t|
    t.integer  "form_id"
    t.text     "data"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "guid",       :limit => 40
  end

  add_index "submissions", ["form_id"], :name => "index_submissions_on_form_id"
  add_index "submissions", ["guid"], :name => "index_submissions_on_guid"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end

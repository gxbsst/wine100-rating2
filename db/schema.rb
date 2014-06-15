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

ActiveRecord::Schema.define(:version => 20140615133223) do

  create_table "awards", :force => true do |t|
    t.integer  "refinery_wine_groups_wine_group_item_id"
    t.string   "award"
    t.integer  "refinery_member_id"
    t.string   "final"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.integer  "wine_id"
    t.integer  "group_id"
    t.integer  "final_user_id"
  end

  create_table "refinery_images", :force => true do |t|
    t.string   "image_mime_type"
    t.string   "image_name"
    t.integer  "image_size"
    t.integer  "image_width"
    t.integer  "image_height"
    t.string   "image_uid"
    t.string   "image_ext"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "refinery_members", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.string   "password_cleartext"
    t.integer  "builder_id"
    t.datetime "last_sign_in_at"
    t.datetime "remember_created_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "position"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "role"
  end

  create_table "refinery_page_part_translations", :force => true do |t|
    t.integer  "refinery_page_part_id"
    t.string   "locale"
    t.text     "body"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  add_index "refinery_page_part_translations", ["locale"], :name => "index_refinery_page_part_translations_on_locale"
  add_index "refinery_page_part_translations", ["refinery_page_part_id"], :name => "index_refinery_page_part_translations_on_refinery_page_part_id"

  create_table "refinery_page_parts", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "title"
    t.text     "body"
    t.integer  "position"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_parts", ["id"], :name => "index_refinery_page_parts_on_id"
  add_index "refinery_page_parts", ["refinery_page_id"], :name => "index_refinery_page_parts_on_refinery_page_id"

  create_table "refinery_page_translations", :force => true do |t|
    t.integer  "refinery_page_id"
    t.string   "locale"
    t.string   "title"
    t.string   "custom_slug"
    t.string   "menu_title"
    t.string   "slug"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "refinery_page_translations", ["locale"], :name => "index_refinery_page_translations_on_locale"
  add_index "refinery_page_translations", ["refinery_page_id"], :name => "index_refinery_page_translations_on_refinery_page_id"

  create_table "refinery_pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "path"
    t.string   "slug"
    t.boolean  "show_in_menu",        :default => true
    t.string   "link_url"
    t.string   "menu_match"
    t.boolean  "deletable",           :default => true
    t.boolean  "draft",               :default => false
    t.boolean  "skip_to_first_child", :default => false
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.string   "view_template"
    t.string   "layout_template"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "refinery_pages", ["depth"], :name => "index_refinery_pages_on_depth"
  add_index "refinery_pages", ["id"], :name => "index_refinery_pages_on_id"
  add_index "refinery_pages", ["lft"], :name => "index_refinery_pages_on_lft"
  add_index "refinery_pages", ["parent_id"], :name => "index_refinery_pages_on_parent_id"
  add_index "refinery_pages", ["rgt"], :name => "index_refinery_pages_on_rgt"

  create_table "refinery_resources", :force => true do |t|
    t.string   "file_mime_type"
    t.string   "file_name"
    t.integer  "file_size"
    t.string   "file_uid"
    t.string   "file_ext"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "refinery_roles", :force => true do |t|
    t.string "title"
  end

  create_table "refinery_roles_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "refinery_roles_users", ["role_id", "user_id"], :name => "index_refinery_roles_users_on_role_id_and_user_id"
  add_index "refinery_roles_users", ["user_id", "role_id"], :name => "index_refinery_roles_users_on_user_id_and_role_id"

  create_table "refinery_test_papers", :force => true do |t|
    t.integer  "wine_id"
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "score"
    t.string   "drink_begin_at"
    t.string   "drink_end_at"
    t.text     "note"
    t.integer  "position"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "group_item_id"
    t.integer  "wine_group_id"
    t.integer  "user_group_id"
  end

  add_index "refinery_test_papers", ["wine_group_id"], :name => "index_refinery_test_papers_on_wine_group_id"

  create_table "refinery_user_groups", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_user_groups_items", :force => true do |t|
    t.integer  "refinery_member_id"
    t.integer  "refinery_user_group_id"
    t.integer  "position"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  create_table "refinery_user_plugins", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.integer "position"
  end

  add_index "refinery_user_plugins", ["name"], :name => "index_refinery_user_plugins_on_name"
  add_index "refinery_user_plugins", ["user_id", "name"], :name => "index_refinery_user_plugins_on_user_id_and_name", :unique => true

  create_table "refinery_users", :force => true do |t|
    t.string   "username",               :null => false
    t.string   "email",                  :null => false
    t.string   "encrypted_password",     :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "sign_in_count"
    t.datetime "remember_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
  end

  add_index "refinery_users", ["id"], :name => "index_refinery_users_on_id"

  create_table "refinery_wine_groups", :force => true do |t|
    t.string   "name"
    t.integer  "judge_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "state"
  end

  create_table "refinery_wine_groups_wine_group_items", :force => true do |t|
    t.integer  "wine_id"
    t.integer  "group_id"
    t.integer  "position"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "refinery_wines", :force => true do |t|
    t.string   "name_zh"
    t.string   "name_en"
    t.string   "region_en"
    t.string   "region_zh"
    t.string   "vingate"
    t.string   "sugar"
    t.string   "grape_vairety"
    t.text     "description"
    t.integer  "position"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "uuid"
    t.string   "wine_style"
    t.string   "alcohol"
  end

  create_table "seo_meta", :force => true do |t|
    t.integer  "seo_meta_id"
    t.string   "seo_meta_type"
    t.string   "browser_title"
    t.string   "meta_keywords"
    t.text     "meta_description"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "seo_meta", ["id"], :name => "index_seo_meta_on_id"
  add_index "seo_meta", ["seo_meta_id", "seo_meta_type"], :name => "index_seo_meta_on_seo_meta_id_and_seo_meta_type"

  create_table "wine100_profiles", :force => true do |t|
    t.string   "contact_name"
    t.string   "contact_job"
    t.string   "contact_phone"
    t.string   "contact_email"
    t.string   "company_name_en"
    t.string   "company_name_zh"
    t.string   "company_add"
    t.string   "company_phone"
    t.string   "company_website"
    t.string   "company_wines_count"
    t.string   "finance_title"
    t.string   "finance_tax_num"
    t.string   "finance_add"
    t.string   "finance_name"
    t.string   "finance_phone"
    t.integer  "wine100_user_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
    t.string   "company_phone_area_code"
  end

  create_table "wine100_sale_chanels", :force => true do |t|
    t.string   "chanel"
    t.integer  "wine100_wine_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.float    "price"
  end

  create_table "wine100_users", :force => true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.string   "email"
    t.string   "password_cleartext"
    t.integer  "builder_id"
    t.datetime "last_sign_in_at"
    t.datetime "remember_created_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phone"
    t.boolean  "is_completed",              :default => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "fogot_password_token"
    t.datetime "fogot_password_created_at"
  end

  create_table "wine100_varieties", :force => true do |t|
    t.string   "culture"
    t.string   "name_zh"
    t.string   "name_en"
    t.string   "pinyin"
    t.string   "origin_name"
    t.string   "percentage"
    t.integer  "wine100_wine_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "wine100_wines", :force => true do |t|
    t.string   "photo"
    t.string   "style"
    t.string   "name_zh"
    t.string   "name_en"
    t.string   "region_1"
    t.string   "region_2"
    t.string   "region_3"
    t.string   "vintage"
    t.string   "alcoholicity"
    t.float    "market_price"
    t.string   "winery_zh"
    t.string   "winery_en"
    t.string   "level"
    t.string   "sweetness"
    t.string   "barcode"
    t.boolean  "is_oak",          :default => true
    t.text     "prize_history"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "wine100_user_id"
    t.integer  "photo_id"
    t.boolean  "status",          :default => false
  end

end

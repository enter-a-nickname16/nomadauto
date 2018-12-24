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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180724022542) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "adminpack"

  create_table "accounts", force: :cascade do |t|
    t.string   "subdomain"
    t.string   "owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "owner_id"
    t.integer  "user_id"
  end

  create_table "activities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action"
    t.string   "trackable_type"
    t.integer  "trackable_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["trackable_type", "trackable_id"], name: "index_activities_on_trackable_type_and_trackable_id", using: :btree
    t.index ["user_id"], name: "index_activities_on_user_id", using: :btree
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "list_id"
    t.string   "name"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_cards_on_list_id", using: :btree
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "owner"
    t.index ["task_id"], name: "index_comments_on_task_id", using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "company"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "website"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "project_id"
    t.integer  "user_id"
    t.index ["project_id"], name: "index_companies_on_project_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.string   "company"
    t.string   "status"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "project_id"
    t.index ["project_id"], name: "index_deals_on_project_id", using: :btree
  end

  create_table "invites", force: :cascade do |t|
    t.string   "email"
    t.integer  "user_group_id"
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.string   "token"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "subdomain"
    t.integer  "project_id"
    t.index ["project_id"], name: "index_invites_on_project_id", using: :btree
  end

  create_table "lists", force: :cascade do |t|
    t.string   "new"
    t.integer  "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plans", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_number"
    t.string   "contact_email"
    t.text     "description"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "projects", force: :cascade do |t|
    t.string  "title"
    t.string  "details"
    t.integer "user_id"
    t.integer "task_id"
    t.integer "deal_id"
    t.integer "company_id"
    t.index ["company_id"], name: "index_projects_on_company_id", using: :btree
    t.index ["deal_id"], name: "index_projects_on_deal_id", using: :btree
    t.index ["task_id"], name: "index_projects_on_task_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "status"
    t.string   "priority"
    t.string   "owner"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "project_id"
    t.index ["project_id"], name: "index_tasks_on_project_id", using: :btree
  end

  create_table "user_groups", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",                 default: false
    t.string   "activation_digest"
    t.boolean  "activated",             default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.integer  "plan_id"
    t.string   "stripe_customer_token"
    t.string   "subdomain"
    t.integer  "invite_id"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
  end

  add_foreign_key "activities", "users"
  add_foreign_key "cards", "lists"
  add_foreign_key "comments", "tasks"
  add_foreign_key "companies", "projects"
  add_foreign_key "deals", "projects"
  add_foreign_key "invites", "projects"
  add_foreign_key "projects", "companies"
  add_foreign_key "projects", "deals"
  add_foreign_key "projects", "tasks"
  add_foreign_key "tasks", "projects"
end

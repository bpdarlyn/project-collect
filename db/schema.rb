# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_08_200422) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_collects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "unit_price"
    t.integer "qty"
    t.float "total_amount"
    t.float "total_collect"
    t.string "current_state"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_item_collects_on_project_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "ci"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "total_amount"
    t.float "total_collect"
    t.date "start_date"
    t.date "end_date"
    t.boolean "active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "promises", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.bigint "item_collect_id", null: false
    t.string "current_state"
    t.string "amount"
    t.string "paid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_collect_id"], name: "index_promises_on_item_collect_id"
    t.index ["person_id"], name: "index_promises_on_person_id"
  end

  add_foreign_key "item_collects", "projects"
  add_foreign_key "promises", "item_collects"
  add_foreign_key "promises", "people"
end

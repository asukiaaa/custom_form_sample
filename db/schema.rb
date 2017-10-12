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

ActiveRecord::Schema.define(version: 20171010082814) do

  create_table "custom_forms", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.text "form_top_html"
    t.text "form_bottom_html"
    t.text "confirmation_top_html"
    t.text "confirmation_bottom_html"
    t.text "finished_html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "top_content"
    t.text "bottom_content"
  end

  create_table "custom_inputs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "label", null: false
    t.boolean "required"
    t.string "input_type", null: false
    t.integer "order"
    t.bigint "custom_form_id"
    t.text "options"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_form_id"], name: "index_custom_inputs_on_custom_form_id"
  end

  create_table "form_records", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "custom_form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_form_id"], name: "index_form_records_on_custom_form_id"
  end

  create_table "record_inputs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "form_record_id"
    t.string "label"
    t.text "value"
    t.string "input_type"
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_record_id"], name: "index_record_inputs_on_form_record_id"
  end

  add_foreign_key "custom_inputs", "custom_forms"
  add_foreign_key "form_records", "custom_forms"
  add_foreign_key "record_inputs", "form_records"
end

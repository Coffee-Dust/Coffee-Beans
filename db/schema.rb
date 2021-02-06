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

ActiveRecord::Schema.define(version: 2021_02_06_184706) do

  create_table "comments", force: :cascade do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.string "content"
  end

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.text "content"
  end

  create_table "reactions", force: :cascade do |t|
    t.integer "reaction_type"
    t.integer "user_id"
    t.string "reactable_type", null: false
    t.integer "reactable_id", null: false
    t.index ["reactable_type", "reactable_id"], name: "index_reactions_on_reactable_type_and_reactable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

end
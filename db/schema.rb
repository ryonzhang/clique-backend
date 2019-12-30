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

ActiveRecord::Schema.define(version: 2019_12_12_154050) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "classcategories", force: :cascade do |t|
    t.integer "classinfo_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_classcategories_on_category_id"
    t.index ["classinfo_id"], name: "index_classcategories_on_classinfo_id"
  end

  create_table "classinfos", force: :cascade do |t|
    t.datetime "time"
    t.integer "duration_in_min"
    t.string "name"
    t.integer "level"
    t.text "general_info"
    t.text "preparation_info"
    t.integer "arrival_ahead_in_min"
    t.text "additional_info"
    t.integer "vacancies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "institution_id"
    t.integer "credit"
    t.integer "min_age"
    t.integer "max_age"
    t.integer "days_in_between"
    t.index ["institution_id"], name: "index_classinfos_on_institution_id"
  end

  create_table "classtags", force: :cascade do |t|
    t.integer "classinfo_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classinfo_id"], name: "index_classtags_on_classinfo_id"
    t.index ["tag_id"], name: "index_classtags_on_tag_id"
  end

  create_table "favoriteinstitutions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_favoriteinstitutions_on_institution_id"
    t.index ["user_id"], name: "index_favoriteinstitutions_on_user_id"
  end

  create_table "feedbacks", force: :cascade do |t|
    t.integer "star_num"
    t.text "comment"
    t.integer "user_id"
    t.integer "institution_id"
    t.integer "classinfo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classinfo_id"], name: "index_feedbacks_on_classinfo_id"
    t.index ["institution_id"], name: "index_feedbacks_on_institution_id"
    t.index ["user_id"], name: "index_feedbacks_on_user_id"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "friend_id"
    t.index ["friend_id"], name: "index_friendships_on_friend_id"
    t.index ["user_id"], name: "index_friendships_on_user_id"
  end

  create_table "institutioncategories", force: :cascade do |t|
    t.integer "institution_id"
    t.integer "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_institutioncategories_on_category_id"
    t.index ["institution_id"], name: "index_institutioncategories_on_institution_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.decimal "star_num"
    t.integer "feedback_count"
    t.text "general_info"
    t.string "country"
    t.string "province"
    t.string "city"
    t.string "street"
    t.string "building"
    t.string "unit"
    t.string "zipcode"
    t.decimal "latitude"
    t.decimal "longitude"
    t.text "location_instruction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "institutiontags", force: :cascade do |t|
    t.integer "institution_id"
    t.integer "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_institutiontags_on_institution_id"
    t.index ["tag_id"], name: "index_institutiontags_on_tag_id"
  end

  create_table "invites", force: :cascade do |t|
    t.integer "user_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "intended_friend_id"
    t.index ["intended_friend_id"], name: "index_invites_on_intended_friend_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.boolean "done"
    t.integer "todo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_id"], name: "index_items_on_todo_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "time"
    t.integer "duration_in_min"
    t.integer "vacancies"
    t.integer "classinfo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["classinfo_id"], name: "index_sessions_on_classinfo_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "todos", force: :cascade do |t|
    t.string "title"
    t.string "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "userclasses", force: :cascade do |t|
    t.integer "user_id"
    t.integer "classinfo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "attended"
    t.index ["classinfo_id"], name: "index_userclasses_on_classinfo_id"
    t.index ["user_id"], name: "index_userclasses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.integer "gender"
    t.date "birthday"
    t.string "city"
    t.string "nationality"
    t.string "phone_number"
    t.string "emergency_name"
    t.string "emergency_contact"
    t.boolean "is_terminated"
    t.boolean "is_searchable"
    t.boolean "is_previous_classes_visible"
    t.boolean "is_coming_classes_visible"
    t.boolean "is_favorite_institutions_visible"
    t.string "username"
    t.string "country"
    t.string "province"
    t.string "street"
    t.string "building"
    t.string "unit"
    t.string "zipcode"
    t.string "role"
  end

end

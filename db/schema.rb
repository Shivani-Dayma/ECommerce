# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_10_10_113609) do
  create_table "add_count_to_carts", force: :cascade do |t|
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "description"
    t.integer "cart_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 1
    t.index ["cart_id"], name: "index_cart_items_on_cart_id"
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count"
    t.index ["user_id"], name: "index_carts_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "address"
    t.integer "contactno"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
  end

  create_table "wishlist_items", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "description"
    t.integer "wishlist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wishlist_id"], name: "index_wishlist_items_on_wishlist_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "carts", "users"
  add_foreign_key "items", "users"
  add_foreign_key "wishlist_items", "wishlists"
  add_foreign_key "wishlists", "users"
end

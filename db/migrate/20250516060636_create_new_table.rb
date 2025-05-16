class CreateNewTable < ActiveRecord::Migration[7.1]
  def change
    enable_extension "plpgsql"

    create_table "bookmarks", force: :cascade do |t|
      t.text "comment"
      t.bigint "movie_id", null: false
      t.bigint "list_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["list_id"], name: "index_bookmarks_on_list_id"
      t.index ["movie_id"], name: "index_bookmarks_on_movie_id"
    end

    create_table "lists", force: :cascade do |t|
      t.string "name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "movies", force: :cascade do |t|
      t.string "title"
      t.text "overview"
      t.string "poster_url"
      t.float "rating"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end

    create_table "reviews", force: :cascade do |t|
      t.text "comment"
      t.integer "rating"
      t.bigint "list_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["list_id"], name: "index_reviews_on_list_id"
    end

    add_foreign_key "bookmarks", "lists"
    add_foreign_key "bookmarks", "movies"
    add_foreign_key "reviews", "lists"
  end
end

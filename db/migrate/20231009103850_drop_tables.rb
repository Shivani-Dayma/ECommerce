class DropTables < ActiveRecord::Migration[7.0]
  def change
    drop_table :wishlist_items
    drop_table :wishlists
  end
end

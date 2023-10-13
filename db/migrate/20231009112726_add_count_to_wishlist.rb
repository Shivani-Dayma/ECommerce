class AddCountToWishlist < ActiveRecord::Migration[7.0]
  def change
    add_column :wishlists, :count, :integer
  end
end

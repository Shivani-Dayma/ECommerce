class AddCountToCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :carts, :count, :integer
  end
end

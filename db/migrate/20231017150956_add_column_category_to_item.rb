class AddColumnCategoryToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :category_type, :string
  end
end

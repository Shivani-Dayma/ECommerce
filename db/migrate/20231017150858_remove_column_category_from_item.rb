class RemoveColumnCategoryFromItem < ActiveRecord::Migration[7.0]
  def change
    remove_column :items, :category, :string
  end
end

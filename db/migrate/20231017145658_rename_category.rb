class RenameCategory < ActiveRecord::Migration[7.0]
  def change
    rename_column :items, :category , :category_type
  end
end

class CreateAddCountToCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :add_count_to_carts do |t|
      t.integer :count
      t.timestamps
    end
  end
end

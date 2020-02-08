class CreateItemCollects < ActiveRecord::Migration[6.0]
  def change
    create_table :item_collects do |t|
      t.string :name
      t.string :description
      t.float :unit_price
      t.integer :qty
      t.float :total_amount
      t.float :total_collect
      t.string :current_state
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateItemCollects < ActiveRecord::Migration[6.0]
  def change
    create_table :item_collects do |t|
      t.string :name
      t.string :description
      t.float :unit_price, default: 0
      t.integer :qty, default: 0
      t.float :total_amount, default: 0
      t.float :total_collect, default: 0
      t.string :current_state
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end

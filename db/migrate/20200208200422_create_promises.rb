class CreatePromises < ActiveRecord::Migration[6.0]
  def change
    create_table :promises do |t|
      t.references :person, null: false, foreign_key: true
      t.references :item_collect, null: false, foreign_key: true
      t.string :current_state
      t.float :amount, default: 0
      t.float :paid, default: 0
      t.timestamps
    end
  end
end

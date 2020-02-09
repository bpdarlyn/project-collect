class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.float :total_amount, default: 0
      t.float :total_collect, default: 0
      t.date :start_date
      t.date :end_date
      t.boolean :active

      t.timestamps
    end
  end
end

class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :total_amount
      t.float :total_collect
      t.date :start_date
      t.date :end_date
      t.boolean :active

      t.timestamps
    end
  end
end

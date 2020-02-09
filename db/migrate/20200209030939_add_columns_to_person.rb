class AddColumnsToPerson < ActiveRecord::Migration[6.0]
  def change
    add_column :people, :address, :string
    add_column :people, :last_name, :string
  end
end

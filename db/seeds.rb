# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
project = Project.create name: 'Retiro Espiritual 2020, Indetenibles',
                         description: 'Indetenibles',
                         start_date: Time.zone.now, end_date: Time.zone.now,
                         active: true

file_items_name = 'presupuesto-2020-retiro.xlsx'

full_path = Rails.root.join('db', 'data', file_items_name)

excel_file = Creek::Book.new full_path
sheet = excel_file.sheets[0]
columns = { qty: 'A', description: 'B', name: 'C', unit_price: 'D', total_amount: 'E' }
sheet.simple_rows.each do |row|
  next if row[columns[:qty]] === 'cant' # check if is the first row to skip the header
  next if !row.present?
  new_item = {
      name: row[columns[:name]],
      description: row[columns[:description]],
      unit_price: row[columns[:unit_price]].to_f,
      qty: row[columns[:qty]].to_i,
      total_amount: row[columns[:total_amount]].to_f,
      project: project,
      current_state: 'pending' # collected, # inactive, # down
  }
  ItemCollect.create(new_item)
end
project.total_amount = ItemCollect.sum(:total_amount)
project.save
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
columns = {qty: 'A', description: 'B', name: 'C', unit_price: 'D', total_amount: 'E'}
sheet.simple_rows.each do |row|
  next if row[columns[:qty]] == 'cant' # check if is the first row to skip the header
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

# Create Promises
sheet_promises = excel_file.sheets[1]
column_promise = {person: 'B', phone: 'C', item: 'D', amount: 'E', paid: 'F'}
sheet_promises.simple_rows.each do |row|
  next if row[column_promise[:person]] == 'Ofrendador' # check if is the first row to skip the header
  next if !row.present?
  person = Person.custom_fields(row['person']).first
  unless person.present?
    person = Person.create(name: row[column_promise[:person]])
  end
  item = ItemCollect.find_by_name row[column_promise[:item]]
  if item.present?
    new_promise = {
        id: person.id,
        name: person.name,
        last_name: person.last_name,
        ci: person.ci,
        phone: row[column_promise[:phone]],
        amount: row[column_promise[:amount]].to_f,
        item_collect_id: item.id
    }
    pf = Builder::PromiseForm.new(new_promise)
    pf.save

    promise = Promise.where(person: person, item_collect: item).first
    promise.current_state = row[column_promise[:paid]] == 'SI' ? 'paid' : 'pending';
    promise.paid = row[column_promise[:paid]] == 'SI' ? row[column_promise[:amount]].to_f : 0;
    promise.save
    p new_promise
  end
end


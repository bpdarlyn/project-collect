class Builder::PromiseForm
  include ActiveModel::Model
  attr_accessor :id, :name, :last_name, :ci, :phone, :amount, :item_collect_id
  validates :name, :amount, :item_collect_id, presence: true
  validate :unique_promise_by_person

  def unique_promise_by_person
    if self.id.present?
      person = Person.find self.id
      if person.promises.where(item_collect_id: self.item_collect_id).any?
        errors.add(:item_collect_id, 'anteriormente prometido!')
      end
    end
  end

  def save
    if valid?
      unless id.present?
        person = Person.find_or_create_by(name: name, last_name: last_name, ci: ci, phone: phone)
        @id = person.reload.id
      end
      person = Person.find id
      person.update(name: name, last_name: last_name, ci: ci, phone: phone)
      Promise.create(person_id: @id, item_collect_id: @item_collect_id,
                     amount: amount, current_state: 'pending')
      true
    else
      false
    end
  end
end

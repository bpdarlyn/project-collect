class Promise < ApplicationRecord
  belongs_to :person
  belongs_to :item_collect

  scope :receivables, -> { where(current_state: 'pending') }

  before_save do
    if self.amount <= self.paid
      self.current_state = 'paid'
    end
  end

  after_save do
    if self.current_state == 'paid'
      item_collect.total_collect += self.paid
      item_collect.save
      project = item_collect.project
      project.total_collect += self.paid
      project.save
    end
  end
end

class ItemCollect < ApplicationRecord
  belongs_to :project

  has_many :promises, dependent: :destroy

  scope :pending, -> { where(current_state: 'pending') }

  before_save do
    if total_collect >= total_amount
      self.current_state = 'collected'
    end
  end

  after_create_commit do
    project.total_amount += total_amount
    project.save
  end

  def remaining_amount
    (self.total_amount - self.total_collect).abs
  end
end

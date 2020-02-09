class Person < ApplicationRecord

  has_many :promises, dependent: :destroy

  include PgSearch::Model
  pg_search_scope :custom_fields, against: [:name, :last_name, :ci, :phone], using: {
      tsearch: { prefix: true }
  }

  def full_name
    "#{name.try(:capitalize)} #{last_name.try(:capitalize)}"
  end
end

class Project < ApplicationRecord
  has_many :item_collects, dependent: :destroy
end

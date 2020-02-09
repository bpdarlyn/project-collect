class Project < ApplicationRecord
  has_many :item_collects, dependent: :destroy

  def receivables_amount
    amount = 0
    item_collects.each do |item_collect|
      item_collect.promises.receivables.each do |promise|
        amount += promise.amount
      end
    end
    amount
  end
end

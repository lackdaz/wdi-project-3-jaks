class AllFlavour < ApplicationRecord
  belongs_to :supplier

  has_and_belongs_to_many :orders
end

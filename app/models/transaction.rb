class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :delivery_address
end

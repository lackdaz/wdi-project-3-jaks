class Transaction < ApplicationRecord
  belongs_to :consumer
  belongs_to :delivery_address
end

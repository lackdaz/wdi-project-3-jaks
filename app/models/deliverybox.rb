class Deliverybox < ApplicationRecord
  belongs_to :deliveryman
  belongs_to :transaction
end

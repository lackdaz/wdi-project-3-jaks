class Order < ApplicationRecord
  belongs_to :all_icecream_container
  belongs_to :transaction
end

class Order < ApplicationRecord
  belongs_to :all_icecream_container
  belongs_to :transaction
  has_and_belongs_to_many :flavours

end

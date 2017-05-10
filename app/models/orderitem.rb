class Orderitem < ApplicationRecord

  belongs_to :user
  belongs_to :supplier
  belongs_to :flavour
  belongs_to :container
  belongs_to :invoice, optional: true



end

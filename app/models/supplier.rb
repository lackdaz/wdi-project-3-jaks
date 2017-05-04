class Supplier < ApplicationRecord

  validates :email,
  presence: true,
  uniqueness: {case_sensitive: false},
  format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :password, length: { in: 8..72 }, on: :create

  has_secure_password
end

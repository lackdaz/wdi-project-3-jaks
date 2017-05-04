class Consumer < ApplicationRecord



validates :email, presence: true,
          uniqueness: {case_sensitive: false},
          format:/\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

validates :password, length: { in: 8..72 }, on: :create

validates :last_name,
          presence: true,
          length: { in: 8..72 }

validates :first_name,
          presence: true,
          length: { in: 8..72 }

  has_secure_password





 def self.find_and_authenticate_consumer(params)
 Consumer.find_by_email(params[:email]).try(:authenticate, params[:password])
 end

end

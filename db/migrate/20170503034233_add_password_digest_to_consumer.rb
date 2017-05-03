class AddPasswordDigestToConsumer < ActiveRecord::Migration[5.0]
  def change
    add_column :consumers, :password_digest, :string
  end
end

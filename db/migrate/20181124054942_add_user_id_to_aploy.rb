class AddUserIdToAploy < ActiveRecord::Migration[5.1]
  def change
    add_column :aploys, :user_id, :integer
    add_column :aploys, :sperior_id, :string
  end
end

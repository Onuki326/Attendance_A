class AddChangestateToAploy < ActiveRecord::Migration[5.1]
  def change
    add_column :aploys, :change_state, :boolean, default: false
    add_column :aploys, :state, :integer, default: "なし"
  end
end

class AddColumnsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean, default: false

    add_column :users, :otp_secret_key, :string
    add_column :users, :otp_module, :integer, default: 0

    add_index :users, :username, unique: true
  end
end

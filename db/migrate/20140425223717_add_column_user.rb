class AddColumnUser < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, default: false

    add_column :users, :activation_token, :string

    add_index :users, :activation_token, unique: true
  end
end

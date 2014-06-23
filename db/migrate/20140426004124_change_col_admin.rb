class ChangeColAdmin < ActiveRecord::Migration
  def change
    change_column :users, :admin, :boolean, :default => true
  end
end

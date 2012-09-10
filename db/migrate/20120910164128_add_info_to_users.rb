class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :school, :string
    add_column :users, :location, :string
  end
end

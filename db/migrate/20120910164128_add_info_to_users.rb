class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :school, :string
    add_column :users, :location, :string
    add_column :users, :description, :text
    add_column :users, :username, :string
    add_column :users, :slug, :string
    add_column :users, :avatar, :string
  
    add_index :users, :slug
  end
end

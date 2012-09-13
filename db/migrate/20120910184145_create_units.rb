class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :slug

      t.timestamps

    end

    add_index :units, :slug
  end
end

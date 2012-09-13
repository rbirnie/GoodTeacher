class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.text :body
      t.string :name
      t.text :description
      t.string :slug

      t.timestamps
    end

    add_index :lessons, :slug
  end
end

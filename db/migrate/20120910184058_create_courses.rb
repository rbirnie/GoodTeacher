class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.text :description
      t.integer :user_id
      t.string :slug

      t.timestamps
    end

    add_index :courses, :slug
  end
end

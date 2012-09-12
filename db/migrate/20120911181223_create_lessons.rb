class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :user_id
      t.text :body
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end

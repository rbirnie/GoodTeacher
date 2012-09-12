class CreateLessonsUnits < ActiveRecord::Migration
  def change
    create_table :lessons_units do |t|
      t.integer :unit_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end

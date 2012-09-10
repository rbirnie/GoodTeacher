class CreateUnitLinks < ActiveRecord::Migration
  def change
    create_table :unit_links do |t|
      t.integer :unit_id
      t.integer :course_id

      t.timestamps
    end
  end
end

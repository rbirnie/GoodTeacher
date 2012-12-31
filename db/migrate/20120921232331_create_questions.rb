class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question
      t.string :modality
      t.integer :assessment_id
      t.integer :creator
      
      t.timestamps
    end
  end
end

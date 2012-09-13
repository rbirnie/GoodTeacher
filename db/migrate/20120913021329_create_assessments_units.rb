class CreateAssessmentsUnits < ActiveRecord::Migration
  def change
    create_table :assessments_units do |t|
      t.string :unit_id
      t.string :assessment_id

      t.timestamps
    end
  end
end

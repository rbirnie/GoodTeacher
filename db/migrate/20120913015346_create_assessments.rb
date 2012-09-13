class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :name
      t.text :description
      t.string :user_id
      t.string :which
      t.text :prompt
      t.string :slug

      t.timestamps
    end

    add_index :assessments, :slug
  end
end

class CreateVocabularyListsUnits < ActiveRecord::Migration
  def change
    create_table :vocabulary_lists_units do |t|
      t.integer :unit_id
      t.integer :vocabulary_list_id

      t.timestamps
    end
  end
end

class CreateVocabListsUnits < ActiveRecord::Migration
  def change
    create_table :vocab_lists_units do |t|
      t.integer :unit_id
      t.integer :vocab_list_id

      t.timestamps
    end
  end
end

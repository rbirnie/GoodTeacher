class CreateVocabularyLists < ActiveRecord::Migration
  def change
    create_table :vocabulary_lists do |t|
      t.string :name
      t.string :description
      t.string :user_id
      t.string :slug

      t.timestamps
    end
  end
end

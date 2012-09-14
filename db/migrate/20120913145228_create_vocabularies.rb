class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :name
      t.text :definition
      t.string :word
      t.text :location
      t.string :user_id
      t.string :vocabulary_list_id
      t.string :slug

      t.timestamps
    end
  end
end
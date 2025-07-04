class CreateGoodMemories < ActiveRecord::Migration[7.1]
  def change
    create_table :good_memories do |t|
      t.text :content
      t.date :date
      t.integer :mood

      t.timestamps
    end
  end
end

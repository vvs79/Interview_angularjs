class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content, limit: 255, null: false
      t.string :answer, limit: 255
      t.references :topic, foreign_key: true, index: true, null: false

      t.timestamps null: false
    end
  end
end

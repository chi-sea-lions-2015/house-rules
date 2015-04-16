class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :content
      t.references :house_assignment, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

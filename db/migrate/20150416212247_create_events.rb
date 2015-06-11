class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.datetime :date
      t.string :description
      t.references :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

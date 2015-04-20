class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :date
      t.string :description
      t.belongs_to :user
      t.references :house, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

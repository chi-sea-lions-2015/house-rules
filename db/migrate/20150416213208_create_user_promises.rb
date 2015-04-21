class CreateUserPromises < ActiveRecord::Migration
  def change
    create_table :user_promises do |t|
      t.boolean :fulfilled, default: false
      t.string :creator
      t.references :promisable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

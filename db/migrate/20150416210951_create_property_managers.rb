class CreatePropertyManagers < ActiveRecord::Migration
  def change
    create_table :property_managers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.references :address, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end

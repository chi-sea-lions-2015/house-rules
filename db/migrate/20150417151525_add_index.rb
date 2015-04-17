class AddIndexes < ActiveRecord::Migration
  def change
    add_index :users, :email
    add_index :addresses, :zip_code
    add_index :property_managers, :name
    add_index :property_managers, :email
    add_index :houses, :name
    add_index :events, :date
    add_index :communal_items, :stock_level
  end
end

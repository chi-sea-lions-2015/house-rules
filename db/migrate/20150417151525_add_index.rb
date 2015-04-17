class AddIndexes < ActiveRecord::Migration
  def change
    add_index :users, :email
    add_index :addresses, :zip_code
    add_index :property_managers, :name
    add_index :houses, :name
    # add_index :housing_assignments, [:user_id, :house_id], unique: true
    # add_index :rules, :housing_assignment
    # add_index :chores, :house
    # add_index :chore_logs, :user
    add_index :events, :date
    add_index :communal_items, :stock_level
    # add_index :messages, :housing_assignment
    # add_index :issues, :user
    # add_index :user_promises, [:user_id, :promisable], unique: true
  end
end

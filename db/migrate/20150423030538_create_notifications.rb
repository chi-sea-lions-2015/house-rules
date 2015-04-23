class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :alert

      t.timestamps null: false
    end
  end
end

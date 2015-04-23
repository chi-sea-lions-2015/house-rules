class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :alert
<<<<<<< HEAD
=======
      t.string :category
      t.integer :house_id
>>>>>>> 1f4414041906a5c227d4bb78e86971c4b7bf8877

      t.timestamps null: false
    end
  end
end

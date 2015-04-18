class CreateIngredientSuggestions < ActiveRecord::Migration
  def change
    create_table :ingredient_suggestions do |t|
      t.string :item

      t.timestamps null: false
    end
  end
end

class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :reason
      t.string :creator
      t.references :issuable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.references :user, index: true, foreign_key: true
      t.string :reason
      t.references :issuable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end

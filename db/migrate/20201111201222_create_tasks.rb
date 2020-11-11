class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.integer :status, default: 0
      t.date :deadline
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end

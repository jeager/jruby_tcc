class CreateExecutions < ActiveRecord::Migration
  def change
    create_table :executions do |t|
      t.integer :timespent
      t.string :status
      t.belongs_to :project, index: true

      t.timestamps null: false
    end
    add_foreign_key :executions, :projects
  end
end

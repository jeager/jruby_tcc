class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.belongs_to :execution, index: true
      t.boolean :checked

      t.timestamps null: false
    end
    add_foreign_key :notifications, :executions
  end
end

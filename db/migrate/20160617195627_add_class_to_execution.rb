class AddClassToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :class_index, :integer
  end
end

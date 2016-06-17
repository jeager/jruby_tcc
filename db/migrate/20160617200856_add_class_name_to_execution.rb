class AddClassNameToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :class_name, :string
  end
end

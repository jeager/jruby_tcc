class AddAccuracyToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :initial_accuracy, :float
  end
end

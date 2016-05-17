class AddAcuracyToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :acuracy, :float
  end
end

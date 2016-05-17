class AddMethodToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :method, :string
  end
end

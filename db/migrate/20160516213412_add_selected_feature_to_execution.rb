class AddSelectedFeatureToExecution < ActiveRecord::Migration
  def change
    add_column :executions, :selected_features, :string
  end
end

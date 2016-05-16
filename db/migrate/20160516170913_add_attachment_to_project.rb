class AddAttachmentToProject < ActiveRecord::Migration
  def change
    add_column :projects, :attachment, :string
  end
end

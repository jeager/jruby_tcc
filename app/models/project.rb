class Project < ActiveRecord::Base
  belongs_to :user
  has_many :executions, :dependent => :delete_all
  mount_uploader :attachment, AttachmentUploader
end

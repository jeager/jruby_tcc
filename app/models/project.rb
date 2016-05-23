class Project < ActiveRecord::Base
  belongs_to :user
  has_many :executions, :dependent => :delete_all
  mount_uploader :attachment, AttachmentUploader
  validates_presence_of :attachment

  before_save :check_arff

	def check_arff
		begin
			if(self.attachment_url[".arff"])
				MlMethods.new.open_dataset(self.attachment_url)
				true
			end
		rescue Exception => e
			false
		end
	end
end

class Project < ActiveRecord::Base
  belongs_to :user
  has_many :executions, :dependent => :destroy
  mount_uploader :attachment, AttachmentUploader
  validates_presence_of :attachment

  before_save :check_arff

	def check_arff
		puts "BEFORE SAVE"
		begin
			if(self.attachment_url[".arff"])
				MlMethods.new.open_dataset(self.attachment_url)
				true
			elsif(self.attachment_url[".csv"])
				MlMethods.new.check_csv(Rails.root.join("public").to_s + self.attachment_url)
				true
			end
		rescue Exception => e
			self.errors.add(:attachment, "Arff ou Csv não compativel.")
			false
		end
	end
end

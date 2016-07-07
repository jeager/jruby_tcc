class Execution < ActiveRecord::Base
  belongs_to :project
  has_one :notification, dependent: :destroy
end

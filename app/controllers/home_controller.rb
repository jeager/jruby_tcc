require 'machine_learning'
class HomeController < ApplicationController

	def index
		@dataset = MachineLearning.new.evaluate
	end
end

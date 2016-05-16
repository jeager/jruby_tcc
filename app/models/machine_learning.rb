require 'ruby-band'

java_import 'weka.filters.Filter'
java_import 'weka.attributeSelection.LinearForwardSelection'

class MachineLearning
	def open_dataset location
		puts Rails.root.to_s + location.to_s
		dataset = Core::Parser.parse_ARFF(Rails.root.join("public").to_s + location.to_s)
	end

	def evaluate location
		# Evaluator
		eval = Weka::Attribute_selection::Evaluator::CfsSubsetEval.new

		# # Search algorithm
		search = LinearForwardSelection.new

		dataset = open_dataset(location)

		filter = Weka::Filter::Supervised::Attribute::AttributeSelection.new

		filter.set do
		  evaluator eval
		  search search
		  data dataset
		end

		return Filter.useFilter(dataset, filter)
	end
end
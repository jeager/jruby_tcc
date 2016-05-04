require 'ruby-band'

java_import 'weka.filters.Filter'
java_import 'weka.attributeSelection.LinearForwardSelection'

class MachineLearning
	def open_dataset
		dataset = Core::Parser.parse_ARFF("/home/jeager/TCC/fs_models/madelon/train.arff")
	end

	def evaluate
		# Evaluator
		eval = Weka::Attribute_selection::Evaluator::CfsSubsetEval.new

		# # Search algorithm
		search = LinearForwardSelection.new

		dataset = open_dataset

		filter = Weka::Filter::Supervised::Attribute::AttributeSelection.new

		filter.set do
		  evaluator eval
		  search search
		  data dataset
		end

		return Filter.useFilter(dataset, filter)
	end
end
require 'ruby-band'

java_import 'weka.filters.Filter'
java_import 'weka.classifiers.meta.AttributeSelectedClassifier'
java_import 'weka.attributeSelection.LinearForwardSelection'
java_import 'weka.attributeSelection.WrapperSubsetEval'

class MachineLearning
	def open_dataset location
		dataset = Core::Parser.parse_ARFF(Rails.root.join("public").to_s + location.to_s)
	end

	def evaluate_by_filter location, evaluator, search_mode, filter
		# Evaluator
		if(evaluator.eql? "CfsSubsetEval")
			eval = Weka::Attribute_selection::Evaluator::CfsSubsetEval.new
		end

		# # Search algorithm
		if(search_mode.eql? "LinearForwardSelection")
			search = LinearForwardSelection.new
		end

		dataset = open_dataset(location)
		if(filter.eql? "AttributeSelection")
			filter = Weka::Filter::Supervised::Attribute::AttributeSelection.new
		end

		filter.set do
		  evaluator eval
		  search search
		  data dataset
		end

		return Filter.useFilter(dataset, filter)
	end

	def evaluate_by_wrapper location
		dataset = open_dataset(location)
		dataset.setClassIndex(dataset.numAttributes() - 1);

		search = LinearForwardSelection.new
		base = Weka::Classifier::Lazy::IBk.new

    filter = Weka::Filter::Supervised::Attribute::AttributeSelection.new
    wrapper = WrapperSubsetEval.new
    wrapper.setClassifier(base)
    wrapper.setFolds(10);
    wrapper.setThreshold(0.001);


    filter.set do
		  evaluator wrapper
		  search search
		  data dataset
		end

		return Filter.useFilter(dataset, filter)
	end
end
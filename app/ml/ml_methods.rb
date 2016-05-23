require 'ruby-band'
require 'java'

java_import 'weka.filters.Filter'
java_import 'weka.classifiers.meta.AttributeSelectedClassifier'
java_import 'weka.attributeSelection.LinearForwardSelection'
java_import 'weka.attributeSelection.WrapperSubsetEval'
java_import 'weka.classifiers.Evaluation'
java_import 'weka.core.Instances'
java_import 'weka.core.converters.ArffSaver'
java_import 'weka.core.converters.CSVLoader'
java_import 'weka.attributeSelection.ReliefFAttributeEval'
java_import 'weka.attributeSelection.Ranker'

class MlMethods
	def open_dataset location
		dataset = Core::Parser.parse_ARFF(Rails.root.join("public").to_s + location.to_s)
		dataset.setClassIndex(dataset.numAttributes() - 1)
		return dataset
	end

	def evaluate_by_filter dataset
		# Evaluator
		eval = Weka::Attribute_selection::Evaluator::CfsSubsetEval.new

		# # Search algorithm
		search = LinearForwardSelection.new

		filter = Weka::Filter::Supervised::Attribute::AttributeSelection.new

		filter.set do
		  evaluator eval
		  search search
		  data dataset
		end

		return Filter.useFilter(dataset, filter)
	end

	def evaluate_by_wrapper dataset

		search = LinearForwardSelection.new
		base = Weka::Classifier::Lazy::IBk.new(1)

    filter = Weka::Filter::Supervised::Attribute::AttributeSelection.new
    wrapper = WrapperSubsetEval.new
    wrapper.setClassifier(base)
    wrapper.setFolds(10);
    wrapper.setThreshold(0.001)


    filter.set do
		  evaluator wrapper
		  search search
		  data dataset
		end

		return Filter.useFilter(dataset, filter)
	end

	def evaluate_by_relief dataset
		# Evaluator
		eval = ReliefFAttributeEval.new

		# # Search algorithm
		search = Ranker.new

		filter = Weka::Filter::Supervised::Attribute::AttributeSelection.new

		filter.set do
		  evaluator eval
		  search search
		  data dataset
		end

		return Filter.useFilter(dataset, filter)
	end

	def execute_with_knn instances
		train_size = (instances.numInstances() * 0.66).round
		test_size = instances.numInstances() - train_size
 		train = Instances.new(instances, 0, train_size)
		test = Instances.new(instances, train_size, test_size)

		classifier = Weka::Classifier::Lazy::IBk.new(1)
		classifier.buildClassifier(train)
		eval = Evaluation.new(train)
 		eval.evaluateModel(classifier, test)

 		return eval
	end

	def create_thread execution
		begin
			Thread.new do				
				dataset = open_dataset(execution.project.attachment_url)
				if(execution.method.eql? 'Filter Method')
		  			results = MachineLearning.new.evaluate_by_filter(dataset)
		  		elsif (execution.method.eql? 'Wrapper Method')
		  			results = MachineLearning.new.evaluate_by_wrapper(dataset)
		  		elsif (execution.method.eql? 'Relief-F')
		  			results = MachineLearning.new.evaluate_by_relief(dataset)
		  		end
		  		features = []
	      		results.enumerateAttributes.each  do |f| 
	        		features << f.name
	    		end
			  	execution.update(:timespent => DateTime.now.to_i - execution.timespent)
			  	eval = MachineLearning.new.execute_with_knn(results)
			  	execution.update(:status => "Done", :selected_features => features.join(","), :acuracy => (1 - eval.errorRate)*100)
			end
		rescue Exception => e
			puts e
			if(exec.status.eql? "Pendig")
				@execution.update(:status =>'Falhou, tentando novamente')
				@execution.reload
				MlMethods.new.create_thread @execution
			elsif (exec.status.eql? "Falhou, tentando novamente")
				@execution.update(:status =>'Falhou.')
			end
		end
	end

	def convert_csv_to_arff csv, file_path
		#load CSV
    loader = CSVLoader.new
    loader.setSource(java.io.File.new(csv.path.to_s))
    data = loader.getDataSet
 		
    #save ARFF
    path = Rails.root.join("public").to_s
    saver = ArffSaver.new
    saver.setInstances(data)
    saver.setFile(java.io.File.new(path + "/" + file_path + "/" + File.basename(csv, ".csv")))
    saver.setDestination(java.io.File.new(path + "/" + file_path + "/" + File.basename(csv, ".csv")))
    saver.writeBatch
    return File.open(path + "/" + file_path + "/" + File.basename(csv, ".csv"))
	end
end
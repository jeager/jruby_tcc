module ExecutionsHelper

	def get_models_list
		array = MlMethods.get_models
		array.delete_at(0)
		return array
	end
end

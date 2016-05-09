json.array!(@executions) do |execution|
  json.extract! execution, :id, :timespent, :status, :project_id
  json.url execution_url(execution, format: :json)
end

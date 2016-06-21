json.array!(@notifications) do |notification|
  json.extract! notification, :id, :execution_id, :checked
  json.url notification_url(notification, format: :json)
end

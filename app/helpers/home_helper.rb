module HomeHelper

	def get_latest_executions
		current_user.notifications.order(updated_at: :desc).limit(5)
	end

	def show_notification_number
		notifications = current_user.notifications.order(updated_at: :desc).limit(5)
		for n in notifications
			if !n.checked
				return true
			end
		end
		return false
	end
end

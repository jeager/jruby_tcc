class HomeController < ApplicationController

	def index
		if(user_signed_in?)
			@executions = Execution.paginate(:page => params[:page], :per_page => 5).joins(:project).where(projects: {user_id: current_user.id}).order(updated_at: :desc)
		end
	end

	def events
		notifications = current_user.notifications.last(5)
		for n in notifications
			n.update(checked: true)
		end
	  respond_to do |format|
      format.js{}
    end
	end

	def update_events
		notifications = current_user.notifications.last(5)
		@update = false
		for n in notifications
			if !n.checked
				@update = true
			end
		end
	  respond_to do |format|
      format.js{}
    end
	end

end

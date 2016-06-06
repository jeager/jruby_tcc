class HomeController < ApplicationController

	def index
		if(user_signed_in?)
			@executions = Execution.paginate(:page => params[:page], :per_page => 5).joins(:project).where(projects: {user_id: current_user.id}).order(updated_at: :desc)
		end
	end
end

module Users
  class ActivitiesController < UsersController
    def index
      @activities = Activity.order("created_at desc")
    end

    def permitted_params
      params.require(:activity).permit(:user, :trackable, :action)
    end
  end
end

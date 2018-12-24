module Users
  class DealsController < UsersController
    before_action :trial_expired?

    def index
      @project = Project.find(params[:project_id])
      authorize @project

      if Deal.exists?
        @deals = @project.deals.all
      end
    end

    def new
      @project = Project.find(params[:project_id])

      @deal = @project.deals.build
      authorize @deal

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @deal }
      end
    end

    def show
      #1st you retrieve the project thanks to params[:project_id]
      @project = Project.find(params[:project_id])
      #2nd you retrieve the tasks thanks to params[:id]
      @deal = @project.deals.find(params[:id])
      authorize @deal

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @deal }
      end
    end

    def create
      #1st you retrieve the project thanks to params[:project_id]
      @project = Project.find(params[:project_id])

      #2nd you create the task with arguments in params[:task]
      @deal = @project.deals.create(deal_params)

        if @deal.save
          # Store form fields via paramaters, into variables
          company = params[:deal][:company]
          status = params[:deal][:status]
          value = params[:deal][:value]
          flash[:success] = "Record Saved."
          redirect_to project_deals_path

          track_activity @deal
        else
          redirect_to new_project_deals_path
        end
    end

    def edit
      @project = Project.find(params[:project_id])

      @deal = @project.deals.find(params[:id])

    end

    def update
      #1st you retrieve the post thanks to params[:post_id]
      @project = Project.find(params[:project_id])
      #2nd you retrieve the comment thanks to params[:id]
      @deal = Deal.find(params[:id])

      respond_to do |format|
        if @deal.update_attributes(deal_params)
          #1st argument of redirect_to is an array, in order to build the correct route to the nested resource comment
          format.html { redirect_to project_deals_path(@project), :notice => 'Task was successfully updated.' }
          flash[:success] = "Your deal has been updated"
          format.xml  { head :ok }

          track_activity @deal
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @deal.errors, :status => :unprocessable_entity }
        end
      end

    end

    def destroy

      #1st you retrieve the project thanks to params[:project_id]
      @project = Project.find(params[:project_id])
      #2nd you retrieve the task thanks to params[:id]
      @deal = Deal.find(params[:id])

      if @deal.destroy
        redirect_to project_deals_path(@project)
      end
    end

    private

    def deal_params
       # To collect data from form, we need to use
       # strong paramaters and whitelist form fields
       params.require(:deal).permit(:company, :status, :value, :project_id, :user_id)
    end
  end
end

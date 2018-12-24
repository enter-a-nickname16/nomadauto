module Users
  class CompaniesController < UsersController
    before_action :trial_expired?

    def index
      @project = Project.find(params[:project_id])
      authorize @project

      if Company.exists?
        @companies = @project.companies.all
      end
    end

    def new

      @project = Project.find(params[:project_id])

      @company = @project.companies.build
      authorize @company

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @company }
      end
    end

    def show
      #1st you retrieve the project thanks to params[:project_id]
      @project = Project.find(params[:project_id])
      #2nd you retrieve the tasks thanks to params[:id]
      @company = @project.companies.find(params[:id])
      authorize @company

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @company }
      end
    end

    def edit
      @project = Project.find(params[:project_id])

      @company = @project.companies.find(params[:id])
    end

    def create
      #1st you retrieve the project thanks to params[:project_id]
      @project = Project.find(params[:project_id])

      #2nd you create the task with arguments in params[:task]
      @company = @project.companies.create(company_params)

        if @company.save
          company = params[:company][:company]
          first_name = params[:company][:first_name]
          last_name = params[:company][:last_name]
          phone_number = params[:company][:phone_number]
          website = params[:company][:website]
          email = params[:company][:email]
          flash[:success] = "Record Saved."
          redirect_to project_companies_path

          track_activity @company
        else
          redirect_to new_project_companies_path
        end
    end

    def update
      #1st you retrieve the post thanks to params[:post_id]
      @project = Project.find(params[:project_id])
      #2nd you retrieve the comment thanks to params[:id]
      @company = Company.find(params[:id])

      respond_to do |format|
        if @company.update_attributes(company_params)
          #1st argument of redirect_to is an array, in order to build the correct route to the nested resource comment
          format.html { redirect_to project_companies_path(@project), :notice => 'Company was successfully updated.' }
          flash[:success] = "Your deal has been updated"
          format.xml  { head :ok }

          track_activity @company
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
        end
      end
    end

    def destroy
      @company = Company.find_by_id(params[:id])

      if @company.destroy
        redirect_to companies_path
      end
    end

    private

    def company_params
       # To collect data from form, we need to use
       # strong paramaters and whitelist form fields
       params.require(:company).permit(:company, :first_name, :last_name, :phone_number, :website, :email)
    end
  end
end

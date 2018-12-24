module Users
  class ListsController < UsersController
    before_action :set_list, only: [:show, :edit, :update, :destroy]

    # GET /lists
    # GET /lists.json
    def index
      @project = Project.find(params[:project_id])
      authorize @project

      @lists = @project.lists.sorted
    end

    # GET /lists/1
    # GET /lists/1.json
    def show
    end

    # GET /lists/new
    def new
      #1st you retrieve the project thanks to params[:project_id]
      @project = Project.find(params[:project_id])

      #2nd you get all the tasks of this project
      @list = @project.lists.build
      authorize @list

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @list }
      end
    end

    # GET /lists/1/edit
    def edit
    end

    # POST /lists
    # POST /lists.json
    def create
      #1st you retrieve the project thanks to params[:project_id]
      @project = Project.find(params[:project_id])

      #2nd you create the task with arguments in params[:list]
      @list = @project.lists.create(list_params)



      respond_to do |format|
        if @list.save
          format.html { redirect_to project_lists_path(@project), notice: 'List was successfully created.' }
          format.xml  { render :xml => @list, :status => :created, :location => [@list.project, @list] }
        else
          format.html { render :new }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /lists/1
    # PATCH/PUT /lists/1.json
    def update
      respond_to do |format|
        if @list.save
          format.html { redirect_to project_lists_path(@project), notice: 'List was successfully created.' }
          format.xml  { render :xml => @list, :status => :created, :location => [@list.project, @list] }
        else
          format.html { render :new }
          format.json { render json: @list.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /lists/1
    # DELETE /lists/1.json
    def destroy
      @list.destroy
      respond_to do |format|
        format.html { redirect_to project_lists_path(@project)  , notice: 'List was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_list
        @list = List.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def list_params
        params.require(:list).permit(:new, :position, :project_id, :user_id)
      end
  end
end

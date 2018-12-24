class CommentsController < UsersController
  def create
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
    @comment = @task.comments.create(params[:comment].permit(:owner, :body))

    redirect_to project_task_path(@project, @task)
  end

  def destroy
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:task_id])
    @comment = @task.comments.find(params[:id])
    @comment.destroy

    redirect_to project_task_path(@project, @task)
  end
end

class ProjectPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(:user_id => user.id)
    end
  end
  
  def initialize(user, project)
    @user = user
    @project = project
  end
  # no need for an index? method here. we will see this in the controller
  def index?
    user.user_projects.map(&:id).include?(@project.id)
  end
  # essentially here we are checking that the user associated to the record
  # is the same as the current user
  def show?
    record.project == project
  end

  def edit?
    user.present?
  end
  # this is actually already the case in ApplicationPolicy but I added 
  # it here for clarity
  def new?
    user.present?
  end

  # who do we want to be able to create a gallery? anyone!
  # so this simple returns true
  def create?
    user.present?
  end
end
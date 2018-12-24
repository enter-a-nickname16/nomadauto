class ListPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(:user_id => user.id)
    end
  end

  def initialize(user, list)
    @user = user
    @list = list
  end
  # no need for an index? method here. we will see this in the controller
  def index?
    user.user_lists.map(&:id).include?(@list.id)
  end
  # essentially here we are checking that the project associated to the record
  # is the same as the current project
  def show?
    record.list == list
  end

  def edit?
    user.user_projects.map(&:id).include?(@project.id)
  end

  # this is actually already the case in ApplicationPolicy but I added
  # it here for clarity
  def new?
    create?
  end

  # who do we want to be able to create a gallery? anyone!
  # so this simple returns true
  def create?
    true
  end
end

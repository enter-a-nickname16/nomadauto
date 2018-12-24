class CompanyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(:user_id => user.id)
    end
  end

  def initialize(user, company)
    @user = user
    @company = company
  end
  # no need for an index? method here. we will see this in the controller
  def index?
    user.user_companies.map(&:id).include?(@company.id)
  end
  # essentially here we are checking that the project associated to the record
  # is the same as the current project
  def show?
    record.compnay == company
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

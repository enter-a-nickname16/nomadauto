class Ability
  include CanCan::Ability

  def initialize(user)
  end

  def validate_user
     unless current_user.id == params[:id].to_i
      raise CanCan::AccessDenied
     end
  end
end

class VisitorsController < ApplicationController
  def index
  end

  def new
    @visitor = Visitor.new
    if Plan.first == nil
      Plan.create(name: 'basic', price: 0)
      Plan.create(name: 'pro', price: 10)
      Plan.create(name: 'invite', price: 0)
    end
    # GET request for which / is our home page
    @basic_plan = Plan.find(1)
    @pro_plan = Plan.find(2)
    @invite_plan = Plan.find(3)
  end

  def create
    @visitor = Visitor.new(secure_params)
    if @visitor.valid?
      @visitor.subscribe
      flash[:notice] = "Signed up #{@visitor.email}."
      redirect_to root_url(subdomain: 'www')
    else
      flash[:danger] = "Please add email address"
    end
  end

  private

  def secure_params
    params.require(:visitor).permit(:email)
  end

end

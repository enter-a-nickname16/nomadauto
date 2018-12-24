class PagesController < ApplicationController
    def home
    end

    def features
      @basic_plan = Plan.find(1)
      @pro_plan = Plan.find(2)
      @invite_plan = Plan.find(3)
    end

    def pricing
      @basic_plan = Plan.find(1)
      @pro_plan = Plan.find(2)
      @invite_plan = Plan.find(3)
    end
end

class WelcomeController < ApplicationController
  def index
    flash[:warning] = "晚安！该睡了"
  end
end

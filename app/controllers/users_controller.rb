class UsersController < ApplicationController
  def index
  	@users = User.all.order("token_bal DESC").page(params[:page]).per_page(5)

  end

  def destroy
  	
  end
end

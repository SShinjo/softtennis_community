class UsersController < ApplicationController
  def edit
  end

  def activity
  end

  def show
  	@user = User.find(params[:id])
  end
end

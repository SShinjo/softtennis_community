class MembersController < ApplicationController

  def create
  	member = Member.where(community_id: params[:member][:community_id],
  						user_id: current_user.id)
  	member.create(member_params)
  	redirect_to(current_user)
  end

  def edit
  end

  private
  	def member_params
  		params.require(:member).permit(:community_id, :user_id)
  	end
end

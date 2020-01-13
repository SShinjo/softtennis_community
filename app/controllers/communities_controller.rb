class CommunitiesController < ApplicationController

  def new
  	@com = Community.new
    @com.members.build
  end

  def create
    @com = Community.create(community_params)
  	redirect_to communities_path
  end

  def index
  	@coms = Community.active.yet
    @coms.each do |com|
      @member = com.members.build
    end
  end

  def edit
  	@com = Community.find(params[:id])
  end

  def update
  	@com = Community.find(params[:id])
  	@com.update
  	redirect_to communities_path
  end

  def destroy
  	@com = Community.find(params[:id])
  	@com.destroy
  	redirect_to(current_user)
  end

  private
  	def community_params
  		params.require(:community).permit(:name, :introduction, :date, :time, :place,
  											:capacity, :is_closed, :is_held, 
                        members_attributes: [:id, :user_id, :community_id, :is_host, :is_member])
  	end
end

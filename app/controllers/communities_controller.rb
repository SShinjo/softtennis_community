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
  # communities-all
  	@coms = Community.active.yet
    @coms.each { |com| @member = com.members.build }

  # communities-user-create
    ids = current_user.members.host.pluck(:community_id)
    @coms_user_create = Community.where(id: ids)

  # communities-user-in
    @coms_user_in = current_user.communities.yet
  end

  def edit
  	@com = Community.find(params[:id])
  end

  def update
  	@com = Community.find(params[:id])
  	@com.update(community_params)
  	redirect_to communities_path
  end

  def destroy
  	@com = Community.find(params[:id])
  	@com.destroy
  	redirect_to(current_user)
  end

  def members
    @com = Community.find(params[:id])
    ids = @com.members.where(is_member: false).pluck(:user_id)
    @members = User.where(id: ids)
  end

# メンバーの募集を締め切る
  def closed
    com = Community.find(params[:id])
    members = Member.where(user_id: params[:community][:member_ids], community_id: com.id)
    members.update_all(is_member: true)
    com.update_attribute(:is_closed, true)
    redirect_to communities_path
  end

  private
  	def community_params
  		params.require(:community).permit(:name, :introduction, :date, :time, :place,
  											:capacity, :is_closed, :is_held, 
                        members_attributes: [:id, :user_id, :community_id, :is_host, :is_member])
  	end
end

class Api::InvitesController < ApplicationController
  before_action :require_channel_membership, only: %i(create)

  def create
    @invite = Invite.new(invite_params)

    if @invite.save
      render :show
    else
      @errors = [@invite.errors.messages]
      render partial: 'api/shared/errors.json.jbuilder',
        status: 400
    end

  end

  def consume
    @invite = Invite.find_by(token: params[:invite_token])

    if logged_in?
      @user = current_user
    else
      @user = User.new_demo_user!
      login!(@user)
    end

    Channel.subscribe_user_ids!(
      [@user.id],
      [@invite.channel, @invite.team.general_channel, @invite.team.random_channel]
    )

    team_membership = @user.team_memberships.find_by(team_id: @invite.team.id)
    @user.update!(default_team_membership_id: team_membership.id)
    @user.default_team_membership.update!(default_channel_id: @invite.channel_id)

    # @invite.destroy!
    redirect_to root_url
  end

  private

  def require_channel_membership
    unless current_user.channel_ids.include?(invite_params[:channel_id].to_i)
      render json: [
        {error: "You do not have permission to create invites for that channel"}
      ], status: 401
    end
  end

  def invite_params
    params.require(:invite).permit(:channel_id)
  end
end

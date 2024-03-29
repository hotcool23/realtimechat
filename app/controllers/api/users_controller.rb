class Api::UsersController < ApplicationController
  before_action :require_login, only: %i(search)
  before_action :require_logout, only: %i(create)

  def create
    @user = user_params[:is_demo] ? User.new_demo_user : User.new(user_params)

    if @user.save
      handle_demo_transfer if current_user # demo user signing up as permanent

      login!(@user)
      render :show
    else
      @errors = [@user.errors.messages]
      render partial: 'api/shared/errors.json.jbuilder',
        status: 400
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render :show
    else
      @errors = [@user.errors.messages]
      render partial: 'api/shared/errors.json.jbuilder',
        status: 400
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def search
    @users = User.where(
        "LOWER(username) LIKE ?",
        "#{params[:query].downcase}%"
      ).
      where.not(id: current_user.id).
      where(is_demo: false).
      order(:username).
      limit(200)

    if params[:team_id]
      @users = @users.includes(:teams).
        where(teams: { id: params[:team_id] })
    end

    render template: 'api/users/search.json.jbuilder'
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :default_team_membership_id, :is_demo)
  end

end

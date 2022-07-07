class UsersController < ApplicationController
  before_action :check_permission
  before_action :find_user, only: %i[destroy]

  def index
    @users = User.all
  end

  def destroy
    @user.destroy!
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
    render_404 unless @user
  end
end

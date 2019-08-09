module Api
  class UsersController < ApplicationController
    before_action :set_user, only: %i[show update destroy]

    def index
      @users = User.all.order('created_at DESC')
      render json: @users
    end

    def show
      render json: @user
    end

    def create
      @user = User.new(user_params)
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        render json: @user, status: :updated
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      head :no_content
    end

    private

    def user_params
      params.require(:user).permit(:nickname, :first_name, :second_name,
                                   :type, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end
  end
end

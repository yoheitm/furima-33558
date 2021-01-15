class UsersController < ApplicationController
  def create
    @user = User.all
  end
end

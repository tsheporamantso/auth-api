class MembersController < ApplicationController
  def index
    render json: current_user, status: :ok
  end
end

class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:homepage]

  def show

  end

  def index
    
  end

  def new
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def create
  end
end

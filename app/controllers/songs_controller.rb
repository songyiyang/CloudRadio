class SongsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def show
  end

  def homepage
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

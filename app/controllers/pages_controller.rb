class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :privacy ]

  def profile
  end

  def privacy
  end
end

class PagesController < ApplicationController
    skip_before_action :verify_authenticity_token
  def home
    render json: {
      success: true
    }
  end
end

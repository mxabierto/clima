class Admin::ApplicationController < ApplicationController
  skip_authorization_check

  before_action :restrict_access

  def index
  end

  def restrict_access
    if false
      redirect_to '/'
    end
  end


end

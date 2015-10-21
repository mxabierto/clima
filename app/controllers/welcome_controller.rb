class WelcomeController < ApplicationController
  def index
    set_content_title('fa fa-lg fa-fw fa-cube', ['Welcome!'])
  end
end

class WelcomeController < ApplicationController
  skip_authorization_check only: [:index, :prueba]
  def index
    #todo: asegurar que todos puedan ver root_url o bien crear un permiso y darles acceso. En principio todos deberian ver un home correspondiente a su role
    #authorize! :read, User
    set_content_title('fa fa-lg fa-fw fa-cube', ['Welcome!'])
    #render 'graphics/flot'
  end

  def prueba
    set_content_title(nil, ['Prueba'])
  end
end

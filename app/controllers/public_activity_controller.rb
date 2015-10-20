class PublicActivityController < ApplicationController
  #authorize_resource except: :index

  def index
    set_content_title('fa-fw fa fa-video-camera', ['Activity Feed'])
    @activities = do_index(PublicActivity::Activity, params, nil, true, 'id desc')
  end

end

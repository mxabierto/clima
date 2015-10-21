class Dev::ExamplesController < ApplicationController
  skip_authorization_check

  def chartkick
    set_content_title('fa fa-lg fa-fw fa-cube', ['chartkick examples'])
    @line_chart = PublicActivity::Activity.group_by_day(:created_at).count
    @column_chart = PublicActivity::Activity.group_by_week(:created_at, week_start: :mon).count
    @pie_chart = PublicActivity::Activity.group_by_week(:created_at, week_start: :mon).count
    @bar_chart = PublicActivity::Activity.group_by_week(:created_at, week_start: :mon).count
    @area_chart = PublicActivity::Activity.group_by_week(:created_at).count
    @multiline_chart = PublicActivity::Activity.group(:trackable_type).group_by_week(:created_at).count
    @geo_chart = {Oaxaca: 15, Chihuahua: 5, Morelos: 10, Chiapas: 8}
  end

  def cors
    set_content_title('fa fa-lg fa-fw fa-cube', ['CORS example'])
    # just render a view with a link for testing CORS functionality
  end

end

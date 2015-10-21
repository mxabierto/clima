class WizardController < ApplicationController
  include Wicked::Wizard

  steps :step1, :step2, :step3

  def create_initial_thing
    @thing = Thing.new
  end

  def show
    @thing = Thing.find(params[:thing_id])
    case step
      when :step1
        puts "in step1"
      when :step2
        puts "in step2"
      when :step3
        puts "in step3"
    end
    render_wizard
  end

  def update
    @thing = Thing.find(params[:thing_id])
    case step
      when :step2
        @thing.update_attributes(params[:thing])
      when :step3
        @thing.update_attributes(params[:thing])
    end
    render_wizard @thing
  end

end

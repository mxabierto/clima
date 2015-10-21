class ThingsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :thing_params

  # GET /things
  def index
    @things = do_index(Thing, params)
  end

  # GET /things/1
  def show
  end

  # GET /things/new
  def new
  end

  # GET /things/1/edit
  def edit
  end

  # POST /things
  def create

    if @thing.save
      redirect_to @thing, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@thing)
      render :new
    end
  end

  # PATCH/PUT /things/1
  def update
    if @thing.update(thing_params)
      redirect_to @thing, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@thing)
      render :edit
    end
  end

  # DELETE /things/1
  def destroy
    @thing.destroy
    redirect_to things_url, notice: t("simple_form.flash.successfully_destroyed")
  end

  private

    # Only allow a trusted parameter "white list" through.
    def thing_params
      params.require(:thing).permit({thing_attaches_files: []}, {thing_attaches_attributes: [:_destroy, :id]}, {thing_contacts_attributes: [:_destroy, :id, :name, :field1, :field2, :field3]}, :name, :age, :price, :expires, :discharged_at, :description, :published, :gender)
    end
end

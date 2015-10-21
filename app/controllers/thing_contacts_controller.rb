class ThingContactsController < ApplicationController
  load_and_authorize_resource except: :index, param_method: :thing_contact_params

  # GET /thing_contacts
  def index
    @thing_contacts = do_index(ThingContact, params)
  end

  # GET /thing_contacts/1
  def show
  end

  # GET /thing_contacts/new
  def new
  end

  # GET /thing_contacts/1/edit
  def edit
  end

  # POST /thing_contacts
  def create

    if @thing_contact.save
      redirect_to @thing_contact, notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@thing_contact)
      render :new
    end
  end

  # PATCH/PUT /thing_contacts/1
  def update
    if @thing_contact.update(thing_contact_params)
      redirect_to @thing_contact, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@thing_contact)
      render :edit
    end
  end

  # DELETE /thing_contacts/1
  def destroy
    @thing_contact.destroy
    redirect_to thing_contacts_url, notice: t("simple_form.flash.successfully_destroyed")
  end

  private

    # Only allow a trusted parameter "white list" through.
    def thing_contact_params
      params.require(:thing_contact).permit(:name, :thing_id)
    end
end

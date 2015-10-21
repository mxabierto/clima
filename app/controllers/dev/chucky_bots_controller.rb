class Dev::ChuckyBotsController < ApplicationController
  # la opcion class: 'ChuckyBot' es para que no intente con Dev::ChuckyBot
  load_resource except: [:index, :new], param_method: :chucky_bot_params, class: 'ChuckyBot'
  authorize_resource except: :index, param_method: :chucky_bot_params, class: 'ChuckyBot'

  # GET /chucky_bots
  def index
    @chucky_bots = do_index(ChuckyBot, params)
  end

  # GET /chucky_bots/1
  def show
  end

  # GET /chucky_bots/new
  def new
    @chucky_bot = ChuckyBot.new
    #convierto los role names en keys con values nil en una hash
    @chucky_bot.authorization = Hash[Role.all.pluck(:name).map {|key| [key, nil]}]
    @chucky_bot.public_activity = {actions: nil, notes: nil}
  end

  # GET /chucky_bots/1/edit
  def edit
  end

  # POST /chucky_bots
  def create
    if @chucky_bot.save
      redirect_to dev_chucky_bot_url(@chucky_bot), notice: t("simple_form.flash.successfully_created")
    else
      generate_flash_msg_no_keep(@chucky_bot)
      render :new
    end
  end

  # PATCH/PUT /chucky_bots/1
  def update
    if @chucky_bot.update(chucky_bot_params)
      redirect_to dev_chucky_bot_url(@chucky_bot), notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@chucky_bot)
      render :edit
    end
  end

  # DELETE /chucky_bots/1
  def destroy
    @chucky_bot.destroy
    redirect_to dev_chucky_bots_url, notice: t("simple_form.flash.successfully_destroyed")
  end

  private

    # Only allow a trusted parameter "white list" through.
    def chucky_bot_params
      params.require(:chucky_bot).permit(:underscore_model_name, :i18n_singular_name, :i18n_plural_name, :fa_icon, :migrate,
                                         {authorization: Role.all.pluck(:name).concat([:notes])},
                                         {public_activity: [:actions, :notes]},
                                         {fields_attributes: [:name, :field_type, :i18n_name, :_destroy, :id,
                                                              formats_options: [:index, :show, :all],
                                                              validations_options: [:notes, validates: []],
                                                              association_options: [:no_relationize, :drop_down_type, :dependent_on_parent] ]}
      )
    end
end

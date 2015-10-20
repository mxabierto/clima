class Admin::SettingsController < Admin::ApplicationController
  def index
    authorize!(:read, Settings)
    search_algoritm
    if params[:q] && params[:q][:meta_sort]
      @q = Settings.unscoped.accessible_by(current_ability, :read).ransack(params[:q])
    else
      @q = Settings.unscoped.order("updated_at DESC, created_at DESC").accessible_by(current_ability, :read).ransack(params[:q])
    end
    nodel_collection = @q.result(distinct: true)
    @settings = nodel_collection.paginate(:page => params[:page], :per_page => per_page(params[:per_page]))
  end

  def search_algoritm
    if params[:search_clear]
      params[:q] = nil
      params[:search_clear] = nil
    end

    if params[:q]
      params[:q].each do |param|
        unless param[1].blank? || param[0] == 's' # la 's' es para que no se ponga rojo cuando solo se hace sort de columnas
          @filter_active = true;
          break
        end
      end
    end
  end

  def per_page(quantity)
    if !quantity.blank?
      params[:per_page] = quantity
    elsif cookies[:per_page].blank?
      params[:per_page] = 20
    end
    params[:per_page]
  end

  def new
    @setting = Settings.new
    @setting.value = ''
  end

  def edit
    @setting = Settings.unscoped.find(params[:id])
  end

  def create
    @setting = Settings.new(setting_params)
    if Settings.unscoped.exists?(var: params[:settings][:var])
      @setting.errors.add(:var, "ya esta en uso")
      render :new
    else
      eval("Settings.#{params[:settings][:var]} = #{params[:settings][:value]}")
      redirect_to admin_settings_path, notice: t("simple_form.flash.successfully_created")
    end
  end

  def update
    eval("Settings.#{params[:settings][:var]} = #{params[:settings][:value]}")
    redirect_to admin_settings_path, notice: t("simple_form.flash.successfully_updated")
  end

  def destroy
    eval("Settings.destroy :#{params[:id]}")
    redirect_to admin_settings_path, notice: t("simple_form.flash.successfully_destroyed")
  end

  private

  def setting_params
    params.require(:settings).permit(:var, :value)
  end

end

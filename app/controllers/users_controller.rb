class UsersController < ApplicationController
  load_and_authorize_resource except: [:index, :create], param_method: :user_params

  # GET /users
  def index
    @users = do_index(User, params)
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    pass = (0..10).map{ ('a'..'z').to_a[rand(26)] }.join
    params[:user][:password] = pass
    params[:user][:password_confirmation] = pass
    @user = User.new(user_params)
    authorize! :create, @user
    if @user.save
      @user.delay(queue: 'mailing').send_reset_password_instructions
      redirect_to @user, notice: t('devise.labels.new_user_email_sent', email: @user.email)
    else
      generate_flash_msg_no_keep(@user)
      render :new
    end
  end

  def create_from_registration
    # implementar para los casos que :registerable este habilitado y el usuario pueda registrarse él mismo
    # aqui no hay creación de password y debería enviar el mail para que confirme el mail
  end



  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: t("simple_form.flash.successfully_updated")
    else
      generate_flash_msg_no_keep(@user)
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: t("simple_form.flash.successfully_destroyed")
  end

  def resend_password_instructions
    @user.delay(queue: 'mailing').send_reset_password_instructions
    redirect_to(users_path, :notice => t('devise.labels.email_sent', email: @user.email))
  end

  private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:remove_avatar, :avatar, :email, :name, :locale, :time_zone, :role_id, :only_api_access)
    end

end

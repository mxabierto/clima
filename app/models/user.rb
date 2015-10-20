require 'valid_email'

class User < ActiveRecord::Base
  include PublicActivity::Model
  tracked only: [:create, :update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
  #tracked recipient: ->(controller, model) { model.xxxx }
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)}
          }

  belongs_to :role
  # Include default devise modules. Others available are:
  # :registerable, :confirmable, :validatable and :omniauthable
  # mas los 7 modulos proveidos por el gem devise_security_extension
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :timeoutable, :lockable
  attachment :avatar, type: :image

  validates :email, email: {message: I18n.t('errors.messages.invalid_email')}, mx: {message: I18n.t('errors.messages.invalid_mx')}

  after_destroy :remove_file

  def only_api_access?
    self.only_api_access
  end

  # sobreescribí este metodo de Devise solo para poder enviar un subject distinto para el mail de bienvenida y el de reset pasword instruction
  def send_reset_password_instructions(subject = nil)
    if subject.nil?
      subject = sign_in_count == 0 ? I18n.t('devise.mailer.welcome.subject') : I18n.t('devise.mailer.reset_password_instructions.subject')
    end
    token = set_reset_password_token
    send_reset_password_instructions_notification(token, subject)
    token
  end

  def except_attr_in_public_activity
    [:id, :remember_created_at, :updated_at, :last_sign_in_at, :current_sign_in_at, :sign_in_count]
  end

  protected

    # sobreescribí este metodo de Devise solo para poder enviar un subject distinto para el mail de bienvenida y el de reset pasword instruction
    def send_reset_password_instructions_notification(token, subject)
      opt = {}
      opt = {subject: subject} if subject
      send_devise_notification(:reset_password_instructions, token, opt)
    end


  private

  def remove_file
    file.delete
  end
end


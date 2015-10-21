class ThingContact < ActiveRecord::Base
	include PublicActivity::Model
  tracked only: [:create, :update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
	#tracked recipient: ->(controller, model) { model.xxxx }
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)}
          }


  belongs_to :thing

  validates :name, :thing_id, presence: true
  validates :name, uniqueness: true
  validates :thing_id, numericality: true




  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end

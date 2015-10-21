class ThingPart < ActiveRecord::Base
	include PublicActivity::Model
  tracked only: [:create, :update, :destroy]
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
	#tracked recipient: ->(controller, model) { model.xxxx }
  tracked :parameters => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)}
          }

  has_and_belongs_to_many :things, join_table: 'things_thing_parts'

  validates :name, presence: true
  validates :name, uniqueness: true




  def except_attr_in_public_activity
    [:id, :updated_at]
  end
end

class Thing < ActiveRecord::Base
	include PublicActivity::Model
	tracked only: [:create, :update, :destroy]
	tracked owner: ->(controller, model) {controller.try(:current_user)}
	#tracked recipient: ->(controller, model) { model.xxxx }
	tracked :on => {:update => proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).keys.size > 0 }}
  tracked :parameters => {
							:attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
							:model_label => proc {|controller, model| model.try(:name)}
          }

	#has_many :documents, as: :attachable#, dependent: :destroy
	#accepts_attachments_for :documents, attachment: :file
	#accepts_nested_attributes_for :documents, allow_destroy: true

	has_many :thing_contacts, dependent: :destroy
	has_many :thing_attaches, dependent: :destroy
	has_and_belongs_to_many :thing_parts, join_table: 'things_thing_parts'

	accepts_nested_attributes_for :thing_contacts, allow_destroy: true
	accepts_attachments_for :thing_attaches, attachment: :file, append: true
	accepts_nested_attributes_for :thing_attaches, allow_destroy: true

	validates_presence_of :name

	def except_attr_in_public_activity
		[:id, :updated_at]
	end
end

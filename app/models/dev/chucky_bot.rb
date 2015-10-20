class ChuckyBot < ActiveRecord::Base
  has_many :fields, class_name: "ChuckyBotField", dependent: :destroy
  serialize :authorization, Hash
  serialize :public_activity, Hash

  validates_presence_of :underscore_model_name

  accepts_nested_attributes_for :fields, allow_destroy: true

  attr_readonly :command

  before_save :generate_command

  private

    def generate_command
      # incluyo nombre de modelo
      c = "rails g chucky_scaff #{underscore_model_name}"

      # incluyo nombre y tipo de campos
      fields_array = Array.new
      fields.each {|f| fields_array << "#{f.name}:#{f.field_type}" }
      c = "#{c} #{fields_array.join(' ')}"

      # incluyo i18n plural and singular names
      unless (i18n_singular_name.blank? || i18n_plural_name.blank?)
        c = "#{c} --i18n_singular_name=#{i18n_singular_name} --i18n_plural_name=#{i18n_plural_name}"
      end

      # incluyo icono del modelo
      unless fa_icon.blank?
        c = "#{c} --fa_icon=#{fa_icon}"
      end


      # incluyo public activity
      c = "#{c} --public_activity=#{public_activity[:actions]}" if public_activity && public_activity[:actions].present?

      # incluyo authorization. --authorization=superuser:manage%director:read-edit-destroy
      fisrt_found = false
      authorization.keys.each do |key|
        unless ['notes', :notes].include?(key)
          if !fisrt_found && authorization[key].present?
            c = "#{c} --authorization=#{key}:#{authorization[key]}"
            fisrt_found = true
          elsif authorization[key].present?
            c = "#{c}%#{key}:#{authorization[key]}"
          end
        end
      end



      # fields... showtime!

      # no relationize
      #option = '--no-relationize='
      values_array = Array.new
      dependents = ""
      fields.each do |field|
        if field.name.include?('_id') && field[:association_options]
          if field[:association_options][:no_relationize] == '1'
            values_array << field.name
          else
            if field[:association_options][:dependent_on_parent].blank?
              self.errors.add(:base, "hay campos con _id que NO tienen definido dependent")
              return false
            else
              dependents = dependents.blank? ? " --dependents=#{field.name}:#{field[:association_options][:dependent_on_parent]}" : "#{dependents}-#{field.name}:#{field[:association_options][:dependent_on_parent]}"
            end
          end
        end
      end
      c = "#{c} --no-relationize=#{values_array.join(':')}" if values_array.size > 0
      c = "#{c}#{dependents}"


      # validations: --validations=precense:nombre_campo1-nombre_campo2%numericality:nombre_campo1-nombre_campo2
      validates = Array.new
      fields.each do |field|
        field[:validations_options][:validates].each do |validate|
          validates << validate
        end
      end
      c_validations = ""
      validates = validates.reject(&:blank?).uniq
      validates.each do |validate|
        c_validations = c_validations.blank? ? "--validations=#{validate}:" : "#{c_validations}%#{validate}:"
        fields.each do |field|
          if field[:validations_options][:validates] && field[:validations_options][:validates].include?(validate)
            c_validations = c_validations.ends_with?(':') ? "#{c_validations}#{field.name}" : "#{c_validations}-#{field.name}"
          end
        end
      end
      c = "#{c} #{c_validations}" unless c_validations.blank?



      # incluyo migrate
      if migrate
        c = "#{c} --migrate=true"
      end


      # at last!
      self.chucky_command = c
    end

end

require 'rails/generators/rails/scaffold/scaffold_generator'

class ChuckyScaffGenerator < Rails::Generators::NamedBase
  desc "Generador mágico que solo la malicia de chucky puede crear"

  source_root File.expand_path('../templates', __FILE__)

  class_option :i18n_singular_name
  class_option :i18n_plural_name
  class_option :fa_icon # --fa_icon='fa fa-lg fa-fw fa-cube' solo funciona si se especifica i18n_singular_name y i18n_plural_name
  class_option 'no-relationize'
  class_option :authorization # ejemplo: --authorization=superuser:manage%director:read-edit-destroy
  class_option :public_activity # ejemplos: --public_activity (inserta codigo por default), --public_activity=create:update
  class_option :migrate # para que se ejecute rake db:migrate: --migrate=true
  class_option :validations # --validations=precense:nombre_campo1-nombre_campo2%numericality:nombre_campo1-nombre_campo2
  class_option :dependents # --dependents=nombre_campo:destroy-nombre_campo:restrict_with_error

  # TODO: implementar los siguientes class_options
  class_option :formats # --formats=nombre_campo:all#money%nombre_campo:index#datelong@show#datesuperlong
  class_option :dropdown # --dropdown=nombre_campo:normal%nombre_campo:filter%nombre_campo:autocomplete
  class_option :help # --help=nombre_campo:"texto del help"%nombre_campo:"texto del help"

  # todo: cuando un campo como 'género' esta en el filtro aparece como string cuando debería ser un select con las pocas opciones que le debería de mandar en el chuccky_scaff



  def invoke_scaffold
    invoke 'scaffold'
  end

  #def copy_and_rename_index
  #  copy_file "#{destination_root}/app/views/#{name.pluralize}/index.html.erb", "app/views/#{name.pluralize}/_index_content.html.erb"
  #  remove_file "app/views/#{name.pluralize}/index.html.erb"
  #  copy_file "index.html.erb", "app/views/#{name.pluralize}/index.html.erb"
  #end

  def i18nize_model
    if options['i18n_singular_name'] && options['i18n_plural_name']
      fa_icon = ''
      fa_icon = "\s\s\s\s\s\s\s\sfa_icon: '#{options['fa_icon']}'\n" if options['fa_icon'].present?
      inject_into_file 'config/locales/es.yml', after: "models:\n" do
        "      #{name}:
        one: #{options['i18n_singular_name']}
        other: #{options['i18n_plural_name']}\n#{fa_icon}".force_encoding('ASCII-8BIT')
      end
    end
  end

  def validatize_model
    if options['validations']
      # --validations=precense:nombre_campo1-nombre_campo2%numericality:nombre_campo1-nombre_campo2
      validations = options['validations'].split('%')
      text_to_inject = ""
      validations.each do |validation|
        validation_key = validation.split(':')[0]
        validation_filds = validation.split(':')[1].split('-')
        text_to_inject = "#{text_to_inject}  validates #{validation_filds.map(&:to_sym).to_s.slice(1, validation_filds.map(&:to_sym).to_s.size - 2)}, #{validation_key}: true\n"
      end
      inject_into_file "app/models/#{name}.rb", after: "< ActiveRecord::Base\n" do
        "#{text_to_inject}"
      end
    end
  end

  def relationize_models
    args.each do |field_and_type|
      field = field_and_type.strip.split(':')[0]
      if field.include? "_id"
        unless options['no-relationize'] && options['no-relationize'].split(':').include?(field)
          inject_into_file "app/models/#{name}.rb", after: "< ActiveRecord::Base\n" do
            "  belongs_to :#{field.split('_id')[0]}\n\n"
          end
          #--dependents=nombre_campo:destroy-nombre_campo:restrict_with_error
          dependent = options['dependents'].split('-').select {|word| word.include?(field)}.first.split(':').last
          inject_into_file "app/models/#{field.split('_id')[0]}.rb", after: "< ActiveRecord::Base\n" do
            "  has_many :#{name.pluralize}, dependent: :#{dependent}\n"
          end
        end
      end
    end
  end

  def authorize_roles
    if options['authorization']
      options['authorization'].split('%').each do |role_and_grants|
        role = role_and_grants.split(':')[0]
        grants = role_and_grants.split(':')[1].split('-')
        inject_into_file "app/models/ability.rb", after: "def #{role}\n" do
          "\t\tcan [:#{grants.join(', :')}], #{name.camelize}\n"
        end
      end
    end
  end

  def public_activize
    if options[:public_activity]
      if options[:public_activity] == 'public_activity'
        tracked = 'tracked'
      else
        tracked = "tracked only: [:#{options[:public_activity].split(':').join(', :')}]"
      end

      inject_into_file "app/models/#{name}.rb", before: "end\n" do
        "\n\n\n
  def except_attr_in_public_activity
    [:id, :updated_at]
  end\n"
      end

      inject_into_file "app/models/#{name}.rb", after: "< ActiveRecord::Base\n" do
        "\tinclude PublicActivity::Model
  #{tracked}
  tracked :on => {update: proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).size > 0 }}
  tracked owner: ->(controller, model) {controller.try(:current_user)}
  #tracked recipient: ->(controller, model) { model.xxxx }
  tracked :on => {:update => proc {|model, controller| model.changes.except(*model.except_attr_in_public_activity).keys.size > 0 }}
  tracked :params => {
              :attributes_changed => proc {|controller, model| model.id_changed? ? nil : model.changes.except(*model.except_attr_in_public_activity)},
              :model_label => proc {|controller, model| model.try(:name)}
          }\n\n\n"
      end
    end
  end


  def migrate_to_ddbb
    rake "db:migrate" if options[:migrate] == 'true'
  end

end



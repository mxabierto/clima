module ApplicationHelper
  def boolean_check_mark(boo)
    if boo
      '<i class="fa fa-check"></i>'.html_safe
    else
      ''
    end
  end

  def creating?
    ["new", "create"].include?(action_name)
  end

  def updating?
    ["edit", "update"].include?(action_name)
  end

  def listing?
    action_name == "index"
  end

  def showing?
    action_name == "show"
  end

  # def link_to_add_fields(name, f, association)
  #   #new_object = f.object.send(association).klass.new
  #   hash = {name: nil, type: nil, i18n_name: nil, formats: nil, validations: nil, association: nil}
  #   new_object = OpenStruct.new(hash)
  #   id = new_object.object_id
  #   fields = f.simple_fields_for(association, new_object, child_index: id) do |builder|
  #     hash.keys.each do |field_name|
  #       render(association.to_s.singularize + "_fields", f: builder, field_name: field_name)
  #     end
  #   end
  #   link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  # end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

end

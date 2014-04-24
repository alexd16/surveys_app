module Backoffice::QuestionsHelper

  def link_to_add_field(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,:child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "addField(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
    :id=>"add-attach",
    :class=>"btn btn-small btn-info")
  end

  def link_to_remove_field(name, f, html_opts = {})
    html_opts[:id] = 'remove-attach' unless html_opts[:id]
    f.hidden_field(:_destroy) +
    link_to_function(raw(name), "removeField(this)", html_opts)
  end

  def question_scope(parent, resource)
    if action_name =~ /new|create/
      backoffice_survey_questions_path(parent, resource)
    elsif action_name =~ /edit|update/
      backoffice_survey_question_path(parent, resource)
    end
  end
end

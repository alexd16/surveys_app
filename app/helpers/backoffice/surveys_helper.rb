module Backoffice::SurveysHelper
  def link_to_remove_field(name, f)
    f.hidden_field(:_destroy) +
    link_to_function(raw(name), "removeField(this)", :id =>"remove-attach")
  end

  def new_survey
    new_survey_path
  end

  def edit_survey(resource)
    edit_survey_path(resource)
  end

  def survey_scope(resource)
    if action_name =~ /new|create/
      backoffice_surveys_path(resource)
    elsif action_name =~ /edit|update/
      backoffice_survey_path(resource)
    end
  end

  def new_attempt
    new_attempt_path
  end

  def attempt_scope(resource)
    if action_name =~ /new|create/
     attempts_path(resource)
    elsif action_name =~ /edit|update/
      attempt_path(resource)
    end
  end

  def link_to_add_field(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,:child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "addField(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
    :id=>"add-attach",
    :class=>"btn btn-small btn-info")
  end

  def survey_status(survey)
    survey.active ? 'active' : 'Disabled'
  end
end
module AttemptsHelper

  def new_attempt(parent)
    new_survey_attempt_path(parent)
  end

  def attempt_scope(parent, resource)
    if action_name =~ /new|create/
     survey_attempts_path(parent, resource)
    elsif action_name =~ /edit|update/
      survey_attempt_path(parent, resource)
    end
  end

end

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

  def option_correct?(option, answer)
    answer.correct? && option == answer.option
  end

  def option_wrong?(option, answer)
    !answer.correct? && option == answer.option
  end

  def attempt_path(survey)
    attempt = current_user.survey_tentatives.find_by(survey_id: survey.id)
    results_attempt_path(attempt)
  end
end

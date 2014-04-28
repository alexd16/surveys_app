class AttemptsController < ApplicationController

  before_filter :load_surveys, only: [:new, :create, :results]
  before_filter :load_active_survey, except: [:index, :results]
  before_filter :normalize_attempts_data, :only => :create

  def new
    @participant = current_user # you have to decide what to do here

    unless @survey.nil?
      @attempt = @survey.attempts.new
      @attempt.answers.build
    end
  end

  def create
    @attempt = @survey.attempts.new(attempt_params)
    @attempt.participant = current_user
    if @attempt.valid? && @attempt.save
      #redirect_to view_context.new_attempt, alert: I18n.t("attempts_controller.#{action_name}")
      redirect_to results_survey_attempt_path(@survey, @attempt), alert: I18n.t("attempts_controller.#{action_name}")
    else
      render :action => :new
    end
  end

  def results
    @attempt = Survey::Attempt.includes(:survey, answers: [question: [:options]]).find(params[:id])
  end

  private

  def load_surveys
    @surveys = Survey::Survey.all
  end

  def load_active_survey
    @survey = Survey::Survey.find params[:survey_id]
  end

  def normalize_attempts_data
    normalize_data!(params[:survey_attempt][:answers_attributes])
  end

  def normalize_data!(hash)
    multiple_answers = []
    last_key = hash.keys.last.to_i

    hash.keys.each do |k|
      if hash[k]['option_id'].is_a?(Array)
        if hash[k]['option_id'].size == 1
          hash[k]['option_id'] = hash[k]['option_id'][0]
          next
        else
          multiple_answers <<  k if hash[k]['option_id'].size > 1
        end
      end
    end

    multiple_answers.each do |k|
      hash[k]['option_id'][1..-1].each do |o|
        last_key += 1
        hash[last_key.to_s] = hash[k].merge('option_id' => o)
      end
      hash[k]['option_id'] = hash[k]['option_id'].first
    end
  end

  def attempt_params
    rails4? ? params_whitelist : params[:survey_attempt]
  end

  def params_whitelist
    params.require(:survey_attempt).permit(Survey::Attempt::AccessibleAttributes)
  end
end

class Backoffice::QuestionsController < ApplicationController
  before_action :authenticate_user!

  before_filter :load_survey

  def new
    @question = Survey::Question.new
    @question.survey_id = @survey.id
  end

  def create
    @question = Survey::Question.new(question_params)
    if(@question.save)
      redirect_to edit_backoffice_survey_path(@survey)
    else
      render :new
    end
  end

  def edit
    @question = Survey::Question.find(params[:id])
  end

  def update
    @question = Survey::Question.find(params[:id])
    if(@question.update_attributes(question_params))
      redirect_to edit_backoffice_survey_question_path(@survey, @question)
    else
      render :edit
    end
  end

  def destroy
    @question = Survey::Question.find(params[:id])
    @question.destroy
    redirect_to edit_backoffice_survey_path(@survey)
  end

  private 

  def load_survey
    @survey = Survey::Survey.find(params[:survey_id])
  end

  #Survey::Question::AccessibleAttributes does not work because it has survey instead of survey_id
  def question_params
    params.require(:survey_question).permit(question_whitelist)
  end

  def question_whitelist
    [:text, :survey_id, {:options_attributes=>[:text, :correct, :weight, :id, :_destroy]}, :id, :_destroy]  
  end

end

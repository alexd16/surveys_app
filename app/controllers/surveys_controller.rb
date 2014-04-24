class SurveysController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @surveys = Survey::Survey.all
  end
  
end

class SurveysController < ApplicationController

  def index
    @surveys = Survey::Survey.all
  end
  
end

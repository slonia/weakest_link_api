class QuestionsController < ApplicationController

  def create
    params['questions'].each do |param|
      Question.create(param.permit(:text, :answer, :shared))
    end
    render json: { questions: Question.all}
  end
end

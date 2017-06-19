class Api::V1::AnswersController < ApplicationController

  def index
    @answers = Answer.all
  end

  def show
    @answer = Answer.find(params[:id])
  end

  def create
    @answer = Answer.new(my_answers_params)
    if @answer.save
      render "api/v1/answers/show"
    else
      render json: { errors: @answer.errors.full_messages, status: :unprocessable_entity, json: @answer, params: my_answers_params }
    end
  end

  def update
    @answer.update(my_answers_params)
    render "api/v1/answers/show"
  end

  def destroy
  end

  private
    def my_answers_params
      params.require(:params).permit(:answer)
    end

end

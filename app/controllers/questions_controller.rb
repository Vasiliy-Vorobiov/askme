class QuestionsController < ApplicationController
  # нужна для отключения токенов при работе через команду CURL
  # для работы с формами в браузере токены нужны
  # skip_before_action :verify_authenticity_token

  def create
    question = Question.create(
      body: params[:question][:body],
      user_id: params[:question][:user_id]
    )

    redirect_to question_path(question)
    # redirect_to '/' # корневой адрес на сайте
    # render text: 'ваш запрос обработан'
  end

  def update
    @question = Question.find(params[:id])
    @question.update(
      body: params[:question][:body],
      user_id: params[:question][:user_id]
    )
    redirect_to question_path(@question)
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path
  end

  def show
    @question = Question.find(params[:id])
  end

  def index
    # в этом случае сортировка будет средставми RUBY , а не средствами SQL
    # @questions = Question.all.sort_by(&:user_id)
    # в этом случае сортировка будет средставми SQL 'user_id DESC' - По убыванию. По умолчанию ASC
    @questions = Question.all.order('user_id')
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

end

class QuestionsController < ApplicationController
  # Теперь поиск вопроса в БД можно удалить из этих действий
  before_action :set_question, only: %i[edit update show destory]

  # нужна для отключения токенов при работе через команду CURL
  # для работы с формами в браузере токены нужны
  # skip_before_action :verify_authenticity_token

  def create
    # question = Question.create(params[:questions]) - Так делать не безопасно,
    # т.к. злоумышленник со страницы в браузере может передать любые значения параметров
    # но рельсы имеют спец методы у объекта params, которые ограничиваю поля, которые можно передать через параметры в модель
    #
    # require - требует чтобы у хэша params был конкретный ключ
    # permit - отсавляет в том объекте, у кторого он был вызван только заданные значения ключей
    question = Question.create(question_params)
    
    # flash[:notice] = 'Ваш вопрос создан' - первый спопсоб передечи сообщения
    redirect_to question_path(question), notice: 'Ваш вопрос создан'
    # redirect_to '/' # корневой адрес на сайте
    # render text: 'ваш запрос обработан'
  end

  def update
    # @question = Question.find(params[:id])
    
    # @question.update(
    #   body: params[:question][:body],
    #   user_id: params[:question][:user_id]
    # )
    # Заменяем на:
    @question.update(question_params)

    redirect_to question_path(@question), notice: 'Вопрос сохранен'
  end

  def destroy
    # @question = Question.find(params[:id])
    @question.destroy

    redirect_to questions_path, notice: 'Вопрос удален'
  end

  def show
    # @question = Question.find(params[:id])
  end

  def index
    # в этом случае сортировка будет средставми RUBY , а не средствами SQL
    # @questions = Question.all.sort_by(&:user_id)
    # в этом случае сортировка будет средставми SQL 'user_id DESC' - По убыванию. По умолчанию ASC
    @questions = Question.all.order('user_id')
    @question = Question.new
  end

  def new
    @question = Question.new
  end

  def edit
    @question = Question.find(params[:id])
  end

  private

  def question_params
    params.require(:question).permit(:body, :user_id)
  end

  def set_question
    @question = Question.find(params[:id])
  end

end

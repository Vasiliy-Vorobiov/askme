class UsersController < ApplicationController
  def new
    session[:current_time] = Time.now
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Вы успешно зарегистрировались'
    else
      flash.now[:alert] = 'Вы неправильно заполнили поля формы регистрации'
      # снова отрисуем форму регистраци - тот html, который он получал, когда заходил на страницу регистрации,
      # ту форму и заполим ее теми полями, которые есть у нас в нашей болванке User, чтобы у него
      # все данные, которые он ввел уже были заполнены

      # render не сработает, потому что запросы шлются xhr-запросами по умолчанию
      # это нужно отключить, добавив в app/views/users/new.html.erb в параметры формы data: {turbo: false}
      # form_with model: @user, data: {turbo: false} do |form|
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to root_path, notice: 'Данные пользователя обновлены'
    else
      flash.now[:alert] = 'Возникли ошибки'
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    # Если пользователь был залогинен, то надо удалить из сессии его ключ
    # это дейсвие destroy разлогинит текущего пользователя
    session.delete(:user_id)

    redirect_to root_path, notice: 'Пользователь удален'
  end

  private

  def user_params
    params.require(:user).permit(
      :name, :nickname, :email, :password, :password_confirmation
    )
  end
end

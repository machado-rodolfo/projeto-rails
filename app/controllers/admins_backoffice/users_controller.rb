class AdminsBackoffice::UsersController < AdminsBackofficeController
  before_action :verify_password, only: [:update]
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admins_backoffice_users_path, notice: "Usuário Criado com Sucesso"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    @user_statistic = @user.user_statistic if @user.user_statistic
  end

  def update
    if @user.update(user_params)
      redirect_to admins_backoffice_users_path, notice: "Usuário Atualizado com Sucesso"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admins_backoffice_users_path, notice: "Usuário Excluído com Sucesso"
    else
      render :index
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def verify_password
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].extract!(:password, :password_confirmation)
    end
  end
end

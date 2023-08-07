class UsersBackofficeController < ApplicationController
  before_action :authenticate_user!
  before_action :build_profile
  layout 'users_backoffice'

  private

  def build_profile
    current_user.build_user_profile if current_user.user_profile.blank?
  end

  def list_questions
    @languages = Language.all
  end

  def show
    @language = Language.find(params[:id])
  end

end

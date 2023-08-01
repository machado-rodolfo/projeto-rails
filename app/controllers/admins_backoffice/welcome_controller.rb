class AdminsBackoffice::WelcomeController < AdminsBackofficeController
  def index
    @total_questions = AdminStatistic.total_questions
    @total_users = AdminStatistic.total_users
    @admins_count = Admin.count
    @languages_count = Language.count
    @subjects_count = Subject.count

    @user_most_right_questions = User.joins(:user_statistic)
                                     .select("users.first_name, users.email, user_statistics.right_questions, users.id")
                                     .order('user_statistics.right_questions DESC')
                                     .first

    @user_most_wrong_questions = User.joins(:user_statistic)
                                     .select("users.first_name, users.email, user_statistics.wrong_questions, users.id")
                                     .order('user_statistics.wrong_questions DESC')
                                     .first

    @user_most_total_questions = User.joins(:user_statistic)
                                      .select("users.first_name, users.email, (user_statistics.right_questions + user_statistics.wrong_questions) AS total_questions, users.id")
                                      .order('total_questions DESC')
                                      .first
  end
end

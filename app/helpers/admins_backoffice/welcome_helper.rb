module AdminsBackoffice::WelcomeHelper
    def user_display_name(user)
      user.first_name.present? ? user.first_name : user.email
    end
  end

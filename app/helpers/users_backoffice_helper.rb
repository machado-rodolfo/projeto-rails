module UsersBackofficeHelper
    def avatar_url
      avatar = current_user.user_profile.avatar
      avatar.attached? ? avatar : 'images.png'
    end
end

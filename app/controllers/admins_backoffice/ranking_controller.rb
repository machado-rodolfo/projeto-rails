class AdminsBackoffice::RankingController < AdminsBackofficeController
  def index
    @users = User.all
  end
end

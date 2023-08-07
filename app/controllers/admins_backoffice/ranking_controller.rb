class AdminsBackoffice::RankingController < AdminsBackofficeController
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end
end

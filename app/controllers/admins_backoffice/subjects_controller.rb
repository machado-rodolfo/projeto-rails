class AdminsBackoffice::SubjectsController < AdminsBackofficeController
    before_action :set_subject, only: [:edit, :update, :destroy]

    def index
        respond_to do |format|
          format.html { @subjects = Subject.page(params[:page]) }
          format.pdf { @subjects = Subject.order(:id) }
          format.json { @subjects = Subject.order(:id)}
        end
    end

    def new
      @subject = Subject.new
    end

    def create
      @subject = Subject.new(params_subject)
      if @subject.save
        redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área cadastrado com Sucesso"
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @subject.update(params_subject)
        redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Atualizado com Sucesso"
      else
        render :edit
      end
    end

  def destroy
    if @subject.destroy
      redirect_to admins_backoffice_subjects_path, notice: "Assunto/Área Excluído com Sucesso"
    else
      render :index
    end
  end

    private

    def params_subject
      params.require(:subject).permit(:description)
    end

    def set_subject
      @subject = Subject.find(params[:id])
    end
  end

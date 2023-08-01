class AdminsBackoffice::LanguagesController < ApplicationController
    def index
      @languages = Language.all
    end

    def show
      @language = Language.find(params[:id])
    end

    def new
      @language = Language.new
    end

    def create
      @language = Language.new(language_params)

      if @language.save
        redirect_to admins_backoffice_languages_path, notice: 'Linguagem criada com sucesso!'
      else
        render :new
      end
    end

    def edit
      @language = Language.find(params[:id])
    end

    def update
      @language = Language.find(params[:id])

      if @language.update(language_params)
        redirect_to admins_backoffice_languages_path, notice: 'Linguagem atualizada com sucesso!'
      else
        render :edit
      end
    end

    def destroy
      @language = Language.find(params[:id])
      @language.destroy

      redirect_to admins_backoffice_languages_path, notice: 'Linguagem excluída com sucesso!'
    end

    private

    def language_params
      params.require(:language).permit(:language_name)
    end
  end

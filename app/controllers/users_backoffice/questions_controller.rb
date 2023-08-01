module UsersBackoffice
  class QuestionsController < UsersBackofficeController
    def list_questions
      @languages = Language.all
    end

    def show
      @question = Question.find(params[:id])
    end

    def show
      @question = Question.find(params[:id])
    end

  end
end

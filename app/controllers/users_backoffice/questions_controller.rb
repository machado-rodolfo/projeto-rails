module UsersBackoffice
  class QuestionsController < UsersBackofficeController
    def list_questions
      @languages = Language.all
    end

    def show
      @question = Question.find(params[:id])
      set_previous_and_next_questions
    end

    private

    def set_previous_and_next_questions
      subject = @question.subject
      all_questions = subject.questions.where.not(id: @question.id)

      if all_questions.length >= 2
        @previous_question = all_questions.sample
        @next_question = (all_questions - [@previous_question]).sample
      else
        @previous_question = all_questions.first
        @next_question = nil
      end
    end
  end
end

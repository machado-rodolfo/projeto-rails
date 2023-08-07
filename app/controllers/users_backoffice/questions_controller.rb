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
      questions = subject.questions
                         .not_answered_by_user(current_user)
                         .where
                         .not(id: @question.id)
                         .to_a

      questions.delete(@question)
      questions.shuffle!

      if questions.length >= 1
        @next_question = questions.first
      else
        @next_question = nil
      end
    end
  end
end

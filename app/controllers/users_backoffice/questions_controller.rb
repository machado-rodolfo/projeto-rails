module UsersBackoffice
  class QuestionsController < UsersBackofficeController
    def list_questions
      @languages = Language.all
    end

    def show
      session[:answered_questions] ||= []

      @question = Question.find(params[:id])
      if session[:answered_questions].include?(@question.id)
        redirect_to_next_unanswered_question
        return
      end

      set_previous_and_next_questions
    end

    private


    def unanswered_questions
      subject = @question.subject
      all_questions = subject.questions.where.not(id: @question.id)
      unanswered_questions = all_questions.reject { |q| session[:answered_questions].include?(q.id) }
      unanswered_questions
    end

    def redirect_to_next_unanswered_question
      all_questions = @question.subject.questions.where.not(id: @question.id)
      next_unanswered_question = all_questions.detect { |q| !session[:answered_questions].include?(q.id) }
      redirect_to users_backoffice_question_path(next_unanswered_question) if next_unanswered_question
    end

    def set_previous_and_next_questions
      subject = @question.subject
      all_questions = subject.questions.where.not(id: @question.id)

      session[:answered_questions] ||= []
      answered_question_ids = session[:answered_questions]

      unanswered_questions = all_questions.reject { |q| answered_question_ids.include?(q.id) }

      if unanswered_questions.length >= 2
        @previous_question = unanswered_questions.sample
        @next_question = (unanswered_questions - [@previous_question]).sample
      elsif unanswered_questions.length == 1
        @previous_question = unanswered_questions.first
        @next_question = nil
      else
        @previous_question = nil
        @next_question = nil
      end
    end
  end
end

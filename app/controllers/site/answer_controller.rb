class Site::AnswerController < SiteController
  def question
    @answer = Answer.find(params[:answer_id])
    question = @answer.question

    if AnswerAttempt.exists?(user: current_user, question: question)
      @already_answered = true
    else
      UserStatistic.set_statistic(@answer, current_user)
      AnswerAttempt.create(user: current_user, question: question, answer: @answer)

      # Criar um registro em AnswerAttempt após salvar a resposta
      AnswerAttempt.create(user: current_user, question: question, answer: @answer)

    end
  end
end

class Site::AnswerController < SiteController
  def question
    @answer = Answer.find(params[:answer_id])
    question = @answer.question

    if AnswerAttempt.exists?(user: current_user, question: question)
      @already_answered = true
    else
      UserStatistic.set_statistic(@answer, current_user)
      AnswerAttempt.create(user: current_user, question: question, answer: @answer)

      question.update(answered: true)
      session[:answered_questions] ||= []
      session[:answered_questions] << question.id
    end
  end
end

class AnswerAttempt < ApplicationRecord
  belongs_to :user
  belongs_to :question
  belongs_to :answer

  validates_uniqueness_of :user_id, scope: :question_id, message: 'Você já respondeu essa pergunta.'
end

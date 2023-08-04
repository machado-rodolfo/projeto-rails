class Question < ApplicationRecord
  belongs_to :subject, counter_cache: true, inverse_of: :questions

  has_many :answers, dependent: :destroy
  has_many :answer_attempts, dependent: :destroy

  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  #Callback
  after_create :set_statistic

  # Kaminari
  paginates_per 5

  # Scopes
  scope :answered_by_user, -> (user) {
    joins(:answer_attempts).where('answer_attempts.user_id = ?', user.id)
  }
  scope :not_answered_by_user, -> (user) {
    joins("LEFT JOIN answer_attempts ON (answer_attempts.question_id = questions.id AND answer_attempts.user_id = #{user.id})").
      where('answer_attempts.id IS NULL').
      group('questions.id')
  }

  scope :_search_subject_, ->(page, subject_id) {
    includes(:answers, :subject).where(subject_id: subject_id).page(page)
  }

  scope :_search_, ->(page, term) {
    includes(:answers, :subject).where('lower(description) LIKE ?', "%#{term.downcase}%").page(page)
  }

  scope :last_questions, ->(page) {
    includes(:answers).order('RANDOM()').page(page)
  }

  def self.number_of_questions_anwered_by_user(user)
    answered_by_user(user).length
  end

  def self.number_of_questions_not_anwered_by_user(user)
    not_answered_by_user(user).length
  end

  private

  def set_statistic
    AdminStatistic.set_event(AdminStatistic::EVENTS[:total_questions])
  end
end

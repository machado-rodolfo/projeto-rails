class Subject < ApplicationRecord
    has_many :questions, dependent: :destroy
    belongs_to :language

    attr_accessor :language_name

    # Kaminari
    paginates_per 5

    accepts_nested_attributes_for :language

    private

    def language_association_presence
        if language_id.blank?
          errors.add(:base, "A disciplina deve estar associada a uma linguagem")
        end
    end

end

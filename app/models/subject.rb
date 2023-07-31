class Subject < ApplicationRecord
    has_many :questions, dependent: :destroy
    belongs_to :language

    attr_accessor :language_name

    # Kaminari
    paginates_per 5
end

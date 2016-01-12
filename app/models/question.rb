class Question < ActiveRecord::Base
  POSSIBLE_LEVELS = %w(beginner good strong)

  belongs_to :topic
  has_and_belongs_to_many :templates
  validates :content,  presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 65_535 }
  validates :answer,   presence: true, length: { maximum: 65_535 }
  validates :topic,    presence: true
  validates :level,    presence: true, inclusion: { in: POSSIBLE_LEVELS, message: "%{value} is not a valid level" }
end

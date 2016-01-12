class Interview < ActiveRecord::Base
  belongs_to :template
  belongs_to :user
  has_many :interview_questions
  has_many :questions, through: :template
  validates :lastname, :firstname, presence: true
  validates :template_id, :target_level, presence: true
end

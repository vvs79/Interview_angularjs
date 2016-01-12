class InterviewQuestion < ActiveRecord::Base
  belongs_to :interview
  validates :interview_id, presence: true
  validates :question_id, presence: true
end

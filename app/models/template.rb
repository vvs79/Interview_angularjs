class Template < ActiveRecord::Base
  has_and_belongs_to_many :questions
  has_many :interviews
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

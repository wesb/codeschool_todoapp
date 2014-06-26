class Task < ActiveRecord::Base
  belongs_to :user
  validates :title, presence: true
  validates :user, presence: true

  scope :completed, -> { where(completed: true) }
end

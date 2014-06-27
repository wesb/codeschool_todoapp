class User < ActiveRecord::Base
	has_many :tasks
	validates :name, presence: true
	validates :email, presence: true
	has_secure_password

  def tasks_completed_percent
    return 0.0 if tasks.empty?
    (tasks.completed.count / tasks.count) * 100
  end
end

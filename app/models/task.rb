class Task < ApplicationRecord
  acts_as_paranoid
  acts_as_list

  belongs_to :project
  has_many :user_tasks
  has_many :users, through: :user_tasks

  acts_as_list scope: :project
end
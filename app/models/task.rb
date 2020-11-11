class Task < ApplicationRecord
  belongs_to :project

  enum status: [:in_process, :done]

  validates :name, presence: true
end

class Task < ApplicationRecord
  belongs_to :project
  enum status: [:in_process, :done]

  validates :name, presence: true
  validates :priority, presence: true, numericality: { only_integer: true }
  validates :status, presence: true

  PRIORITIES = [
    ['Low', 1],
    ['Lower Middle', 2],
    ['Middle', 3],
    ['Upper Middle', 4],
    ['High', 5]
  ]

  def up
    if self.priority < 5
      self.priority += 1
      save
    end
  end

  def down
    if self.priority > 1
      self.priority -= 1
      save
    end
  end

end

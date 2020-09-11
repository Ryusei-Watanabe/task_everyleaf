class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length:{in:1..140}
  enum priority: {High: 0, Medium: 1, Low: 2}
  scope :title_search, -> (title) { where('title LIKE(?)',"%#{title}%")}
  scope :state_search, -> (state) { where( state: "#{state}")}
  scope :created_at_sort, -> {all.order( created_at: :desc)}
  scope :deadline_sort, -> {all.order( deadline: :asc)}
  scope :priority_sort, -> {all.order(priority: :asc)}
end

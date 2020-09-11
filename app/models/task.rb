class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length:{in:1..140}
  scope :title_search, -> (title) { where('title LIKE(?)',"%#{title}%")}
  scope :state_search, -> (state) { where( state: "#{state}")}
  scope :created_at_sort, -> {all.order( created_at: :desc)}
  scope :deadline_sort, -> {all.order( deadline: :desc)}
end

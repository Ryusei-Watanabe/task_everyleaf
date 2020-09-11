class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length:{in:1..140}
  scope :title_search, -> (title) { where('title LIKE(?)',"%#{title}%")}
  scope :state_search, -> (state) { where( state: "#{state}")}
end

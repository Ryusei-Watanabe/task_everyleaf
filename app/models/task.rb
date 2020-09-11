class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length:{in:1..140}
  scope :search, -> (search_params) do
    return if search_params.blank?
    search(search_params[:title])
  end

  # def クラスメソッとself.all_search()
  #   .search()
  # end

  scope :search, -> (title) { where('title LIKE(?)',"%#{title}%") if title.present?}
end

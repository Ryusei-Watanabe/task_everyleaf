FactoryBot.define do
  factory :task do
    title { 'task_title' }
    content { 'task_content' }
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
  end
end

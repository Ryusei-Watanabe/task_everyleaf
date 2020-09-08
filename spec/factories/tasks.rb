FactoryBot.define do
  factory :task do
    title { 'task1' }
    content { 'task_content1' }
  end
  factory :second_task, class: Task do
    title { 'task2' }
    content { 'task_content2' }
  end
end

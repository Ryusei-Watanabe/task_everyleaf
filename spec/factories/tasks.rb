FactoryBot.define do
  factory :task do
    state { 'Waiting' }
    title { 'test1' }
    content { 'task_content1' }
  end
  factory :second_task, class: Task do
    state { 'Done' }
    title { 'test2' }
    content { 'task_content2' }
  end
end

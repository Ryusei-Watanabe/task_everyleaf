FactoryBot.define do
  factory :task do
    title { 'test1' }
    content { 'task_content1' }
    deadline {'1996-03-18 00:00:00'.to_datetime}
    state { 'Waiting' }
  end
  factory :second_task, class: Task do
    title { 'test2' }
    content { 'task_content2' }
    deadline {'1023-8-10 00:00:00'.to_datetime}
    state { 'Done' }
  end
  factory :third_task, class: Task do
    title { 'sample3' }
    content { 'task_content2' }
    deadline {'2020-09-11 00:00:00'.to_datetime}
    state { 'Done' }
  end
end

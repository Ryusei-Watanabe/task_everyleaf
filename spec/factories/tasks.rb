FactoryBot.define do
  factory :task do
    title { 'test1' }
    content { 'task_content1' }
    deadline {'2020-09-13-18 00:00:00'.to_datetime}
    state { 'Waiting' }
    priority {'High'}
    user
  end
  factory :second_task, class: Task do
    title { 'test2' }
    content { 'task_content2' }
    deadline {'2020-09-20 00:00:00'.to_datetime}
    state { 'Done' }
    priority {'Medium'}
    user
  end
  factory :third_task, class: Task do
    title { 'test3' }
    content { 'task_content2' }
    deadline {'2020-09-11 00:00:00'.to_datetime}
    state { 'Done' }
    priority {'Low'}
    user
  end
end

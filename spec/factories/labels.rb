FactoryBot.define do
  factory :label do
    name { 'label01' }
  end
  factory :secound_label, class: Label do
    name { 'label02' }
  end
end

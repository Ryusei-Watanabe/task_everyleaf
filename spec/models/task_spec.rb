require 'rails_helper'

RSpec.describe Task, type: :model do
  it "is valid with a title, content is 1 or more and less than 140" do
    task = Task.new(
      title: "Rspec",
      content: "task_rspec_test")
      expect(task).to be_valid
  end
end

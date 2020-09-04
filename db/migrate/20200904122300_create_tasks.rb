class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.string :state
      t.datetime :deadline
      t.timestamps
    end
  end
end

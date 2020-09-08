require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task_title', with: 'task_rspec'
        fill_in 'task_content', with: 'task_rspec'
        click_on 'commit'
        expect(page).to have_content 'task_rspec'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        expect(page).to have_content 'task1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        # 新規作成
        task = FactoryBot.create(:second_task)
        # ページ遷移
        visit tasks_path
        # 取得
        task_list = all('.article')
        # check!!
        expect(task_list[0]).to have_content 'task2'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:second_task)
         visit task_path(task.id)
         expect(page).to have_content 'task2'
       end
     end
  end
end

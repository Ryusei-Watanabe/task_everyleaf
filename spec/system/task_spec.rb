require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        select 'Done', from: 'task[state]'
        select 'High', from: 'task[priority]'
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
        visit tasks_path
        task_list = all('.article')
        expect(task_list[2]).to have_content 'test1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.article')
        expect(task_list[0]).to have_content 'test3'
      end
    end
    context '終了期限が降順の場合' do
      it "一番上に終了期限が先のタスクが一番上" do
        visit tasks_path
        click_on '終了期限'
        expect(page).to have_content 'test2'
      end
    end
    context '優先順位の高い順にした場合' do
      it "優先順位が高いタスクを作成順に表示" do
        visit tasks_path
        click_on '優先順位'
        expect(page).to have_content 'test1'
      end
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task[title]', with: 'tes'
        click_on 'commit'
        expect(page).to have_content 'test2'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit tasks_path
        select 'Done', from: 'task[state]'
        expect(page).to have_content 'test2'
        # プルダウンを選択する「select」について調べてみること
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        # ここに実装する
        visit tasks_path
        fill_in 'task[title]', with: 'tes'
        select 'Done', from: 'task[state]'
        expect(page).to have_content 'test2'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:second_task)
         # taskのidが必要なので、beforeではダメ!!
         visit task_path(task.id)
         # binding.irb
         expect(page).to have_content 'test2'
       end
     end
  end
end

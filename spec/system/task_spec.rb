require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user) }
  let!(:second_task) { FactoryBot.create(:second_task, user: user) }
  let!(:third_task) { FactoryBot.create(:third_task, user: user) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'user@sample.com'
    fill_in 'session[password]', with: 'aaaaaa'
    click_on 'commit'
    visit tasks_path
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        select 'Done', from: 'task[state]'
        select 'High', from: 'task[priority]'
        select '2019', from: 'task[deadline(1i)]'
        fill_in 'task_title', with: 'task_rspec'
        fill_in 'task_content', with: 'task_rspec'
        click_on 'commit'
        expect(page).to have_content 'Done'
        expect(page).to have_content 'High'
        expect(page).to have_content '2019'
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
      it "一番上に終了期限が遅いタスクが一番上に表示される" do
        visit tasks_path
        click_on '終了期限'
        expect(page).to have_content '2020-09-20'
      end
    end
    context '優先順位の高い順にした場合' do
      it "優先順位が高いタスクを作成順に表示" do
        visit tasks_path
        click_on '優先順位'
        expect(page).to have_content 'High'
      end
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task[title]', with: '2'
        click_on 'commit'
        expect(page).not_to have_content 'test3'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        visit tasks_path
        select 'Done', from: 'task[state]'
        expect(page).to have_content 'Done'
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
        expect(page).to have_content 'Done'
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
         task = FactoryBot.create(:second_task, user: user)
         # taskのidが必要なので、beforeではダメ!!
         visit task_path(task.id)
         expect(page).to have_content 'test2'
       end
     end
  end
end

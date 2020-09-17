require 'rails_helper'
# ラベル付new
# ラベル付edit
# 詳細のラベル(複数)
# ラベル検索
RSpec.describe 'ラベリング機能', type: :system do
  let!(:label) { FactoryBot.create(:label) }
  let!(:secound_label) { FactoryBot.create(:secound_label) }
  let!(:user) { FactoryBot.create(:user) }
  before do
    visit new_session_path
    fill_in 'session[email]', with: 'user@sample.com'
    fill_in 'session[password]', with: 'aaaaaa'
    click_on 'commit'
    visit tasks_path
  end
  describe '【 ラベル付け 】' do
    context '【 新しくタスクが登録される場合 】' do
      it '【 ラベルを登録できる 】' do
        visit new_task_path
        fill_in 'task[title]', with: 'sample1'
        fill_in 'task[content]', with: 'sample_content'
        check 'label01'
        click_on 'commit'
        expect(page).to have_content 'sample1'
      end
    end
    context '【 既存のタスクを編集する場合 】' do
      it '【 複数のラベルをつけることができる 】' do
        task = FactoryBot.create(:task, user: user)
        visit edit_task_path(task.id)
        check 'label01'
        check 'label02'
        click_on 'commit'
        visit task_path(task.id)
        expect(page).to have_content 'label01'
        expect(page).to have_content 'label02'
      end
    end
  end
  describe '【 検索機能 】' do
    before do
    end
    context '【 ラベルのみで検索した場合 】' do
      it '【 検索したラベルと一致するものが表示される 】' do
        task1 = FactoryBot.create(:task, user: user)
        visit edit_task_path(task1.id)
        check 'label01'
        click_on 'commit'
        task2 = FactoryBot.create(:second_task, user: user)
        visit edit_task_path(task2.id)
        check 'label02'
        click_on 'commit'
        select 'label01', from: 'task[label_id]'
        click_on 'Search'
        click_on 'task_wrapper'
        expect(page).to have_content 'label01'
        # 2つある内の一つを正しくソートできていれば、task_wrapperで詳細ページに飛んで、ラベルを確認することができる。
      end
    end
  end
end

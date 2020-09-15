require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  before do
    FactoryBot.create(:user)
    FactoryBot.create(:admin_user)
  end
  # let!(:user) { FactoryBot.create(:user) }
  # let!(:admin_user) { FactoryBot.create(:admin_user) }
    describe '【 ユーザ登録のテスト 】' do
      context '【 ユーザを新規登録した場合 】' do
        it '【 作成したユーザーのプロフィールが表示される 】' do
          visit new_user_path
          fill_in 'user[name]', with: 'user'
          fill_in 'user[email]', with: 'user@sample.com'
          fill_in 'user[password]', with: 'aaaaaa'
          fill_in 'user[password_confirmation]', with: 'aaaaaa'
          click_on 'commit'
          expect(page).to have_content 'user'
        end
      end
      context '【 ユーザがログインせずタスク一覧画面に飛ぼうとした場合 】' do
        it '【 ログイン画面が表示される】' do
          visit tasks_path
          expect(current_path).to eq new_session_path
        end
      end
    end
  describe '【 セッション機能のテスト 】' do
    context '【 一般ユーザでログインできる場合 】' do
      it '【 ログインができること 】' do
        visit new_session_path
        fill_in 'session[email]', with: 'user@sample.com'
        fill_in 'session[password]', with: 'aaaaaa'
        click_on 'commit'
        expect(page).to have_content 'user'
      end
      it '【 自分の詳細画面(マイページ)に飛べること 】' do
      end
      it '【 一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること 】' do
      end
      it '【 ログアウトができること 】' do
      end
      it '【 一般ユーザは管理画面にアクセスできないこと 】' do
      end
    end
  end
  describe '【 管理画面のテスト 】' do
    context '【 管理ユーザでログインした場合】' do
      it '【 管理ユーザは管理画面にアクセスできること 】' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin@sample.com'
        fill_in 'session[password]', with: 'aaaaaa'
        click_on 'commit'
        expect(page).to have_content 'admin'
      end
      it '【 管理ユーザはユーザの新規登録ができること 】' do
        # 【テストの処理（〇〇になることを期待する）】
      end
      it '【 管理ユーザはユーザの詳細画面にアクセスできること 】' do
        # 【テストの処理（〇〇になることを期待する）】
      end
      it '【 管理ユーザはユーザの編集画面からユーザを編集できること 】' do
        # 【テストの処理（〇〇になることを期待する）】
      end
      it '【 管理ユーザはユーザの削除をできること 】' do
        # 【テストの処理（〇〇になることを期待する）】
      end
    end
  end
end

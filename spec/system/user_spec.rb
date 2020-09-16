require 'rails_helper'
RSpec.describe 'ユーザ管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  describe '【 ユーザ登録のテスト 】' do
    context '【 ユーザを新規登録した場合 】' do
      it '【 作成したユーザーのプロフィールが表示される 】' do
        visit new_user_path
        fill_in 'user[name]', with: 'test'
        fill_in 'user[email]', with: 'test@sample.com'
        fill_in 'user[password]', with: 'aaaaaa'
        fill_in 'user[password_confirmation]', with: 'aaaaaa'
        click_on 'commit'
        expect(page).to have_content 'test'
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
        visit new_session_path
        fill_in 'session[email]', with: 'user@sample.com'
        fill_in 'session[password]', with: 'aaaaaa'
        click_on 'commit'
        click_on 'プロフィール'
        expect(page).to have_content 'userのページ'
        expect(page).to have_content 'user@sample.com'
      end
      it '【 一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること 】' do
        visit new_session_path
        fill_in 'session[email]', with: 'user@sample.com'
        fill_in 'session[password]', with: 'aaaaaa'
        click_on 'commit'
        visit user_path(admin_user.id)
        expect(current_path).to eq tasks_path
      end
      it '【 ログアウトができること 】' do
        visit new_session_path
        fill_in 'session[email]', with: 'user@sample.com'
        fill_in 'session[password]', with: 'aaaaaa'
        click_on 'commit'
        click_on 'ログアウト'
        expect(page).to have_content 'サインアップ'
        expect(page).to have_content 'ログイン'
      end
      it '【 一般ユーザは管理画面にアクセスできないこと 】' do
        visit new_session_path
        fill_in 'session[email]', with: 'user@sample.com'
        fill_in 'session[password]', with: 'aaaaaa'
        click_on 'commit'
        visit admin_users_path
        expect(current_path).to eq root_path
      end
    end
  end
  describe '【 管理画面のテスト 】' do
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'admin@sample.com'
      fill_in 'session[password]', with: 'aaaaaa'
      click_on 'commit'
    end
    context '【 管理ユーザでログインした場合】' do
      it '【 管理ユーザは管理画面にアクセスできること 】' do
        visit admin_users_path
        expect(page).to have_content 'New'
      end
      it '【 管理ユーザはユーザの新規登録ができること 】' do
        visit admin_users_path
        click_on 'New'
        fill_in 'user[name]', with: 'test02'
        fill_in 'user[email]', with: 'test02@sample.com'
        fill_in 'user[password]', with: 'aaaaaa'
        fill_in 'user[password_confirmation]', with: 'aaaaaa'
        click_on 'commit'
        click_on 'プロフィール'
        expect(page).to have_content 'test02'
      end
      it '【 管理ユーザはユーザの詳細画面にアクセスできること 】' do
        visit admin_user_path(user.id)
        expect(page).to have_content 'user'
      end
      it '【 管理ユーザはユーザの編集画面からユーザを編集できること 】' do
        visit edit_admin_user_path(user.id)
        fill_in 'user[name]', with: 'test3'
        click_on 'commit'
        visit admin_user_path(user.id)
        expect(page).to have_content 'test3'
      end
      it '【 管理ユーザはユーザの削除をできること 】' do
        visit admin_user_path(user.id)
        page.accept_confirm do
          click_on '削除'
        end
        visit admin_users_path
        expect(page).to_not have_content 'user@sample.com'
      end
    end
  end
end
